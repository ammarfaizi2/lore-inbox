Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSKSKGi>; Tue, 19 Nov 2002 05:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSKSKGi>; Tue, 19 Nov 2002 05:06:38 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:63460 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S264867AbSKSKGg>; Tue, 19 Nov 2002 05:06:36 -0500
Message-ID: <3DDA0E63.9050307@torque.net>
Date: Tue, 19 Nov 2002 21:11:47 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@pyxtechnologies.com>
CC: "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
References: <Pine.LNX.4.10.10211182138310.2779-200000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Greetings Doug et al.
> 
> Please consider the addition of this simple void ptr to the scsi_request
> struct.  The addition of this simple void pointer allows one to map any
> and all request execution caller the facility to search for a specific
> operation without having to run in circles.  Hunting for these details
> over the global device list of all HBA's is silly and one of the key
> reasons why there error recovery path is so painful.
> 
> 
> Scsi_Request    *req = sc_cmd->sc_request;
> blah_blah_t     *trace = NULL;
> 
> trace = (blah_blah_t *)req->trace_ptr;
> 
> 
> Therefore the specific transport invoking operations via the midlayer will
> have the ablity to track and trace any operation.

Andre,
No need to convince me: I have already put a similar pointer
in that structure in lk 2.5 (for either sd, st, sr or sg to use).
In sg case's it saved some ugly looping in (what was formerly
called) the bottom half handler. Sounds like your motivation is
similar.

Doug Gilbert



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265666AbRF2PBp>; Fri, 29 Jun 2001 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265694AbRF2PBf>; Fri, 29 Jun 2001 11:01:35 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:51204 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265666AbRF2PBX>; Fri, 29 Jun 2001 11:01:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ph. Marek" <marek@bmlv.gv.at>,
        "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
Subject: Re: Q: sparse file creation in existing data?
Date: Fri, 29 Jun 2001 17:03:41 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at> <3.0.6.32.20010629145529.00922ae0@pop3.bmlv.gv.at>
In-Reply-To: <3.0.6.32.20010629145529.00922ae0@pop3.bmlv.gv.at>
MIME-Version: 1.0
Message-Id: <0106291703410C.00419@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 June 2001 14:55, Ph. Marek wrote:
> Hmmm, on second thought ... But I'd like it better to have a fcntl for
> hole-making :-)
> Maybe I'll implement this myself.

A far superior interface would be:

    ssize_t sys_clear(unsigned int fd, size_t count)

A stub implementation would just write zeroes.  You would need a generic way 
of determining whether holes are supported for a particular file - this is 
where an fcntl would be appropriate.  It would also be nice to know this 
before opening/creating a file, perhaps by fcntling the directory.

But don't expect to have a real, hole-creating implementation any time soon.  
Taming the truncate races is hard enough as it is with a single boundary at 
the end of a file.  Taking care of multiple boundaries inside the file is 
far, far harder.  Talk to Al Viro or the Ext3 team if you want the whole ugly 
story.

--
Daniel

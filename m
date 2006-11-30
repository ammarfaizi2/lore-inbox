Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030843AbWK3RVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030843AbWK3RVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030844AbWK3RVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:21:45 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:49097 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030845AbWK3RVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:21:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eir9MIeF8KMX5sZXzp/taj+C+jUdmBQvEkJVn2p9J5ACHN04D62cYZUBFEGhhh0fhEcfhtJQ/qeyY4PDFBLtj7yoQa684RFI5LT2GVapIqB++qbJXssajg9/75LyB5Gk7Be5ZoPrvwfCs0C04IpA83OHxQ7DMXRy/s8cYoqjj88=
Message-ID: <bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
Date: Thu, 30 Nov 2006 11:21:44 -0600
From: "Matt Garman" <matthew.garman@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <456DE85F.50806@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
	 <456DE85F.50806@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> > How might I achieve having TCP_NODELAY effectively set for all sockets
> > (by default)?  Is there a new/different kernel config option, a patch,
> > a sysctl or proc setting?  Or can I "fake" this behavior by, e.g.
> > setting a send buffer sufficiently small?
>
> This is a bad idea and breaks api compatibility.  Nagle is very
> important for sockets being used for things like telnet.  Other
> applications, like ftp, should already disable nagle themselves.

I don't want to change the API at all.  I'm using a closed-source, 3rd
party library.  Using strace, I can see that the library does *not* do
a setsockopt(...TCP_NODELAY...) on opened sockets.  Since I can't
change the library, I would like to patch and/or configure my kernel
so that all TCP/IP sockets default to TCP_NODELAY.

Also, if my understanding of Nagle is correct, I think you have that
backwards: Nagle should be disabled (i.e. TCP_NODELAY) for telnet,
mouse movements, etc: we always want to send our packets, regardless
of size or previous packet ACK.

Thanks,
Matt

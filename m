Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUHFNRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUHFNRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUHFNRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:17:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53696 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265248AbUHFNRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:17:10 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806062331.GE10274@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	 <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
	 <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de>
	 <1091739966.8418.38.camel@localhost.localdomain>
	 <20040806054424.GB10274@suse.de>  <20040806062331.GE10274@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091794470.16306.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 13:14:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 07:23, Jens Axboe wrote:
> Perhaps if you acknowledge that it wont be perfect, then it's becomes
> more acceptable imo. So you can issue some commands that do write to the
> drive even as a regular user, but none that permanently alter the state
> of the drive or its media (to the best of our knowledge). Other commands
> you let through.

The code you included is roughly the kind of filtering I mean except
that unknown commands must not get through without CAP_SYS_RAWIO.
Anything that is doubtful doesn't get through. As to the location you do
it there are at least two ways to handle that. One is that you stick the
CAP_SYS_RAWIO of the requester in a flag in the request block the other
is that you do it at the top layer. Some BSD socket implementations take
the former approach and it works very well as the driver can make a
final decision but is told the rights attached to the command.

So once its

	switch()
	{
		case READ6:
		case READ10:
				...
			/* Always */
			break;
		case WRITE6:
		case WRITE10:
			...
			/* if write */
		default:
			if(capable(CAP_SYS_RAWIO))
			/* Only administrators get to do arbitary things */

I agree with it. 

Alan


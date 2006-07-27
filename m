Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWG0SEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWG0SEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWG0SEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:04:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42117 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750937AbWG0SEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:04:05 -0400
Message-ID: <44C8FFFE.3010402@zytor.com>
Date: Thu, 27 Jul 2006 11:03:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: Re: O_CAREFUL flag to disable open() side effects
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>	 <1154021616.13509.68.camel@localhost.localdomain>	 <44C8F8E3.1070306@zytor.com> <1154023516.13509.72.camel@localhost.localdomain>
In-Reply-To: <1154023516.13509.72.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-07-27 am 10:33 -0700, ysgrifennodd H. Peter Anvin:
>> For a conventional file, directory, or block device O_CAREFUL is a 
>> no-op.  For ttys it would typically behave similar to O_NONBLOCK 
>> followed immediately by a fcntl to clear the nonblock flag.
> 
> Linus long ago suggested O_NONE to go with RO/RW/WO. Its not that hard
> to do with the current file op stuff but you have to work out what the
> access permission semantics of it are and what it means for ioctl etc

O_NONE might be a good thing to do with that, but I think the "careful" 
semantics should be a separate flag (we shouldn't have different side 
effects depending on the individual mode.)

O_NONE would be a useful complement to O_CAREFUL though; for some 
devices O_CAREFUL with anything *other than* O_NONE might be an invalid 
operation.

The semantics would obviously be device dependent, but the basic idea 
should be that opening with O_CAREFUL should not disturb the global 
state of the device; it should only create a handle.

	-hpa


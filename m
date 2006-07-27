Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWG0ReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWG0ReF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWG0ReF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:34:05 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49316 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751899AbWG0ReD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:34:03 -0400
Message-ID: <44C8F8E3.1070306@zytor.com>
Date: Thu, 27 Jul 2006 10:33:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: O_CAREFUL flag to disable open() side effects
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI> <1154021616.13509.68.camel@localhost.localdomain>
In-Reply-To: <1154021616.13509.68.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-07-27 am 20:05 +0300, ysgrifennodd Pekka J Enberg:
>> Sure. Though I wonder if sys_frevoke is enough for us and we can drop 
>> sys_revoke completely.
> 
> Alas not. Some Unix devices have side effects when you open() them. 
> 

Dumb thought: would it make sense to add an O_CAREFUL flag to open(), to 
disable side effects?  It seems that a number of devices have this issue 
and one have to jump through weird hoops to configure them.  Obviously, 
a file descriptor obtained with O_CAREFUL may not be fully functional, 
at the device driver's option.

For a conventional file, directory, or block device O_CAREFUL is a 
no-op.  For ttys it would typically behave similar to O_NONBLOCK 
followed immediately by a fcntl to clear the nonblock flag.

	-hpa

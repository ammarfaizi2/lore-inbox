Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVAPUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVAPUUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVAPUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:20:19 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:49091 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262576AbVAPUUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:20:05 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: conglomerate objects in reference*.pl 
In-reply-to: Your message of "Sun, 16 Jan 2005 11:45:33 -0800."
             <41EAC45D.30207@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 06:47:43 +1100
Message-ID: <15456.1105904863@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 11:45:33 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>Keith Owens wrote:
>> On Sat, 15 Jan 2005 20:49:33 -0800, 
>> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>>>I'm seeing some drivers/*/built-in.o that should be ignored AFAIK,
>>>but they are not ignored.  Any ideas?

   ld -m elf_i386  -r -o drivers/ide/legacy/built-in.o drivers/ide/legacy/hd.o
   ld -m elf_i386  -r -o drivers/ide/built-in.o drivers/ide/legacy/built-in.o

drivers/ide/legacy/built-in.o and drivers/ide/built-in.o consist of
exactly one object in your build.  From scripts/reference*.pl:

# Ignore conglomerate objects, they have been built from multiple objects and we
# only care about the individual objects.  If an object has more than one GCC:
# string in the comment section then it is conglomerate.  This does not filter
# out conglomerates that consist of exactly one object, can't be helped.

built-in.o added to the conglomerate list to help a bit.


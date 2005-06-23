Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVFWUIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVFWUIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVFWUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:03:30 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:43843 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263082AbVFWT4X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:56:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lqnCNDCjqfkmXNBk66S4vqAzYHQILwyx+1HkAY67ADtJYfsPRPFoyid4mIUHku5BtMUWv5PfcjA10s319s4YaLjT3f4o5O6JyRkxHp9HFXVToBP3pkK1hid/OO0j57pi4rjpfuOG+sOUZe+oEO58DKRs4LNRaaK/O9Be/kVyXKA=
Message-ID: <8783be66050623125612b19b32@mail.gmail.com>
Date: Thu, 23 Jun 2005 15:56:20 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Olivier Galibert <galibert@pobox.com>, Vladimir Saveliev <vs@namesys.com>,
       Pekka Enberg <penberg@gmail.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <20050623162325.GA21971@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
	 <84144f0205062223226d560e41@mail.gmail.com>
	 <42BA67C9.7060604@namesys.com>
	 <1119543302.4115.141.camel@tribesman.namesys.com>
	 <20050623162325.GA21971@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Olivier Galibert <galibert@pobox.com> wrote:

> No, I think he means the traditional:
> 
> reiser4_fill_super()
> {
>    if (init_a())
>      goto failed_a;
.
.
.

IMO this works very well when the initialization always completes or
fails totally in a single routine.  When your init routine can leave
something partially inited, then putting all of the cleanup code in a
single function and using the enums eliminates duplicate code and
makes things easier to read.  (it's a state machine like many device
drivers and network stacks).

Also, perhaps a compromise on the asserts at the beggining of
functions.  If they are moved into a header file, say
resier4_contracts.h and replaced with a single macro, you get most of
the benefits and elminate most of the clutter.  If properly done,
there may even be some advantages gained by auto generating the
conttact.h file(s) from some sort of formal spec or design doc.

    Ross

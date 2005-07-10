Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVGJKzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVGJKzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 06:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGJKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 06:55:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5548 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261886AbVGJKzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 06:55:44 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Roman Zippel <zippel@linux-m68k.org>, Bryan Henderson <hbryan@us.ibm.com>
Subject: Re: share/private/slave a subtree - define vs enum
Date: Sun, 10 Jul 2005 13:55:33 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com> <Pine.LNX.4.61.0507081845170.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507081845170.3743@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507101355.33338.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2005 19:57, Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Jul 2005, Bryan Henderson wrote:
> 
> > I wasn't aware anyone preferred defines to enums for declaring enumerated 
> > data types.
> 
> If it's really enumerated data types, that's fine, but this example was 
> about bitfield masks.
> 
> > Isn't the only argument for defines, "that's what I'm used to."?
> 
> defines are not just used for constants and there is _nothing_ wrong with 
> using defines for constants.

Apart from the wart that defines know zilch about scopes.
Thus completely fine looking code will give you atrociously
obscure compiler message. Real world example for userspace:

# cat t.c
#include <errno.h>
#include <stdio.h>

void f() {
    char errno[] = "hello world";
    puts(errno);
}

# gcc -c t.c
t.c: In function `f':
t.c:5: error: function `__errno_location' is initialized like a variable
t.c:5: error: conflicting types for '__errno_location'
/usr/include/bits/errno.h:38: error: previous declaration of '__errno_location' was here
--
vda


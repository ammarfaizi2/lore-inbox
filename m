Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbUKANmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbUKANmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbUKANmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:42:09 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29965 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262688AbUKANla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:41:30 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Date: Mon, 1 Nov 2004 15:40:25 +0200
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <20041031201500.GA4498@thunk.org> <1099308472.18809.60.camel@localhost.localdomain>
In-Reply-To: <1099308472.18809.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411011540.25175.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 13:27, Alan Cox wrote:
> 2. Most of the pages of libxml2.so don't get paged in by a typical
> application

This assumes that 'needed' functions are close together.
This can be easily not the case, so you end up using only
a fraction of fetched page's content.

Also this argument tend to defend library growth.
"It's mostly unused, don't worry". What if that
is not true? How to compare RAM footprint
of new versus old lib in this case?
Just believe that it didn't get worse?

This can't be checked easily:
even -static compile can fail to help.
glibc produce nearly 400kb executable for

int main() { return 0; }

because init code uses printf on error paths and
that pulls i18n in. How many kilobytes is really
runs - who knows...
--
vda


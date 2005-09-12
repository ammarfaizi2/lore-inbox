Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVILHUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVILHUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVILHUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:20:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58330 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751193AbVILHUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:20:54 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [GIT PATCHES] final kbuild update before fix-only period
Date: Mon, 12 Sep 2005 10:19:25 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050910200347.GA3762@mars.ravnborg.org> <200509111526.58010.vda@ilport.com.ua> <20050911140001.GA7544@mars.ravnborg.org>
In-Reply-To: <20050911140001.GA7544@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121019.25835.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 17:00, Sam Ravnborg wrote:
> > BUG()s etc which are using __FILE__ to get source filename
> > print horribly long names like
> > 
> > /.share/usr/src2/kernel/linux-2.6.13-mm2.src/drivers/net/.../some.c
> > 
> > if one builds kernel in separate object dir.
> > This is ugly and wastes space in kernel image. Any ideas how to fix this?
> 
> I have once experimenting with this on request from Olaf.
> The only way I could fine was to pass a new define:
> -DKBUILD_FILE='short-file-name' to gcc.
> This has the sideeffect that we always accuse the main .c file for
> being the culprint.
> gcc warns if we override __FILE__
> 
> __FILE__ is used in 123 files of wich 26 is within arch/
> so it will take a while to change...

I think the worst offender is BUG/BUG_ON():

# grep -r BUG . | grep -v DEBUG | wc -l
5208

~5000 copies of "/.share/usr/src2/kernel/linux-2.6.13-mm2.src" string
in my kernel??! That's not funny...
 
> I can cook up something if there is interest.

/me is interested.
--
vda

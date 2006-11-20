Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966773AbWKTXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966773AbWKTXoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966880AbWKTXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:44:11 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:9530 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966773AbWKTXoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:44:09 -0500
Date: Mon, 20 Nov 2006 15:43:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: jes@trained-monkey.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
Message-Id: <20061120154359.9013bace.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0611210029140.6242@scrub.home>
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
	<20061120004147.GC31879@stusta.de>
	<4560FB07.2040102@oracle.com>
	<20061120102438.94ff4b0a.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0611202254200.6242@scrub.home>
	<45623803.7070103@oracle.com>
	<Pine.LNX.4.64.0611210029140.6242@scrub.home>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 00:30:36 +0100 (CET) Roman Zippel wrote:

> Hi,
> 
> On Mon, 20 Nov 2006, Randy Dunlap wrote:
> 
> > > I cannot reproduce this. Could you try to run qconf within gdb for a
> > > backtrace (adding -g to HOST_EXTRACFLAGS might get more useful output).
> > 
> > Sure, let me know what you want next.
> 
> Hmm, an uninitialize field is IMO the only thing that could go wrong here.

Great, that fixes it.  Thanks!

> bye, Roman
> 
> ---
>  scripts/kconfig/qconf.cc |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/scripts/kconfig/qconf.cc
> ===================================================================
> --- linux-2.6.orig/scripts/kconfig/qconf.cc
> +++ linux-2.6/scripts/kconfig/qconf.cc
> @@ -1259,6 +1259,7 @@ void ConfigSearchWindow::search(void)
>   * Construct the complete config widget
>   */
>  ConfigMainWindow::ConfigMainWindow(void)
> +	: searchWindow(0)
>  {
>  	QMenuBar* menu;
>  	bool ok;
> -


---
~Randy

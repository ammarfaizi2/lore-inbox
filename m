Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUFPVSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUFPVSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUFPVSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:18:10 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:5045 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264777AbUFPVSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:18:06 -0400
Date: Wed, 16 Jun 2004 23:17:17 +0200 (CEST)
From: Egmont Koblinger <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: jsimmons@pentafluge.infradead.org
Cc: Zilvinas Valinskas <zilvinas@gemtek.lt>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       David MacKenzie <djm@gnu.ai.mit.edu>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
In-Reply-To: <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
Message-ID: <Pine.LNX.4.58L0.0406162313450.20508@sziami.cs.bme.hu>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087395424.5314.2.camel@swoop.gemtek.lt> <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 jsimmons@pentafluge.infradead.org wrote:

Hi,

> +#ifdef TIOCGWINSZ
> +  int size_was_set = 0;
> +  int cols, rows;
     ^^^^^^^^^^^^^^^
These should both be initialized to -1 because...

> -	      set_window_size ((int) integer_arg (argv[k]), -1,
> -			       fd, device_name);
> +	      rows = integer_arg (argv[k]);
> +	      size_was_set = 1;

[...]

> -	      set_window_size (-1, (int) integer_arg (argv[k]),
> -			       fd, device_name);
> +	      cols = integer_arg (argv[k]);
> +	      size_was_set = 1;

...here maybe only one of them is set, but...

> +  if (size_was_set)
> +    {
> +      set_window_size (rows, cols, fd, device_name);

...here both of them are used. Looking at the body of size_was_set()
and the code that was removed from stty it's clear that -1 means don't
change, while 0 means change to 0.



-- 
Egmont

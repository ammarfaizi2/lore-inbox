Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUAPWLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbUAPWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:08:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:15624 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265779AbUAPV4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:56:09 -0500
Date: Fri, 16 Jan 2004 22:56:01 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Romain Lievin <romain@rlievin.dyndns.org>
cc: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] "gconfig" removed root folder...
In-Reply-To: <20040115214416.GA25409@rlievin.dyndns.org>
Message-ID: <Pine.LNX.4.58.0401162249560.2530@serv>
References: <1074177405.3131.10.camel@oebilgen> <20040115214416.GA25409@rlievin.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Romain Lievin wrote:

>  	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
>  					     (user_data));
> +
> +	/* protect against 'root directory' bug */
> +	trailing = fn[strlen(fn)-1];
> +	if(stat(fn, &sb) == -1) return;
> +	if(S_ISDIR(sb.st_mode))
> +		if(trailing != '/')
> +			strcat((char *)fn, "/");
>
>  	if (conf_write(fn))
>  		text_insert_msg("Error", "Unable to save configuration !");

Um, I thought gtk++ also had an option that prevents the selection of
directories.
A test like this should be added to conf_write().

bye, Roman

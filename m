Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWBTIrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBTIrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 03:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBTIrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 03:47:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6108 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932398AbWBTIrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 03:47:02 -0500
Subject: Re: + daemonize-detach-from-current-namespace.patch added to -mm
	tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: B.Steinbrink@gmx.de, ebiederm@xmission.com, viro@ftp.linux.org.uk
In-Reply-To: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
References: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 09:46:57 +0100
Message-Id: <1140425218.2979.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -puN kernel/exit.c~daemonize-detach-from-current-namespace kernel/exit.c
> --- devel/kernel/exit.c~daemonize-detach-from-current-namespace	2006-02-19 20:36:58.000000000 -0800
> +++ devel-akpm/kernel/exit.c	2006-02-19 20:36:58.000000000 -0800
> @@ -360,6 +360,9 @@ void daemonize(const char *name, ...)
>  	fs = init_task.fs;
>  	current->fs = fs;
>  	atomic_inc(&fs->count);
> +	exit_namespace(current);
> +	current->namespace = init_task.namespace;
> +	get_namespace(current->namespace);
>   	exit_files(current);

not that it'll matter much here, but this is normally the wrong order of
refcounting ;) First take the count, then start using it ;)


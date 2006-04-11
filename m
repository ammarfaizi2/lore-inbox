Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWDKLic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWDKLic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWDKLic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:38:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61353 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750775AbWDKLib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:38:31 -0400
Date: Tue, 11 Apr 2006 13:38:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix block device symlink name
In-Reply-To: <20060410151651.01fd6167.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.61.0604111337450.928@yvahk01.tjqt.qr>
References: <20060410151651.01fd6167.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>@@ -352,6 +353,10 @@ static char *make_block_name(struct gend
> 		return NULL;
> 	strcpy(name, block_str);
> 	strcat(name, disk->disk_name);
>+	/* ewww... some of these buggers have / in name... */
>+	s = strchr(name, '/');
>+	if (s)
>+		*s = '!';
> 	return name;
> }
> 

Can they have multiple '/'? If so, we need a while loop.


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932798AbWJINIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbWJINIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWJINIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:08:40 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:38053 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932796AbWJINIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:08:39 -0400
Message-ID: <452A49D5.4060904@s5r6.in-berlin.de>
Date: Mon, 09 Oct 2006 15:08:37 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [2.6.19 patch] ATA must depend on BLOCK
References: <20061008231621.GM6755@stusta.de>
In-Reply-To: <20061008231621.GM6755@stusta.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch fixes the following compile error with CONFIG_ATA=y, 
> CONFIG_BLOCK=n:
[...]
>  config ATA
>  	tristate "ATA device support"
> +	depends on BLOCK
>  	depends on !(M32R || M68K) || BROKEN
>  	depends on !SUN4 || BROKEN
>  	select SCSI

The Kconfig isn't broken but the tool which generated the .config.

"config ATA\ select SCSI" implies a dependency of ATA on SCSI. SCSI
depends on BLOCK.

Therefore "select SCSI" && "config SCSI\ depends on BLOCK" implies
either "config ATA\ select BLOCK" or "config ATA\ depends on BLOCK".

{Ignore all what I said if ATA code directly uses the block API. Usages
of the block API to manipulate SCSI data structures, particularly the
request queue, does not necessarily count as independent usage of the
block API though.}
-- 
Stefan Richter
-=====-=-==- =-=- -=---
http://arcgraph.de/sr/

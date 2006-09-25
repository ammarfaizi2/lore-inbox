Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWIYQMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIYQMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWIYQMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:12:36 -0400
Received: from sibyl.beware.dropbear.id.au ([203.38.218.57]:27841 "EHLO
	sibyl.beware.dropbear.id.au") by vger.kernel.org with ESMTP
	id S1751105AbWIYQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:12:34 -0400
DomainKey-Signature: a=rsa-sha1; s=dk1; d=beware.dropbear.id.au; c=simple; q=dns;
	b=yXIyrGv5JadXIsEJUhO39vMq0yIZhrZb4w7TNcTewlW8/B/nESy/GJLRvk031Ebee
	094Gzbqpe93212413m/vw==
Subject: Re: [patch] qla1280 command timeout
From: Ian Dall <ian@beware.dropbear.id.au>
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, scott.bailey@eds.com,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <yq04puwcmau.fsf@jaguar.mkp.net>
References: <yq04puwcmau.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 01:41:47 +0930
Message-Id: <1159200707.32368.16.camel@sibyl.beware.dropbear.id.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 05:44 -0400, Jes Sorensen wrote:
> Hi,
> 
> This one is originally from Ian Dall via bugzilla.kernel.org - Ian if
> you wish to add a Signed-off-by please do, couldn't add it since you
> didn't leave one in bugzilla.

See below.

> Anyway the patch seems obviously correct (famous last words) and it
> would be nice to get into 2.6.19.
> 
> Thanks,
> Jes
> 
> Original patch from Ian Dall in bugzilla. Set command timeout as
> specified by the SCSI layer rather than hardcode it to 30 seconds. I
> have received a couple of reports of people hitting this one with
> various tape configurations and the patch looks obviously correct.
>                                                                   - Jes
> 
> >From http://bugzilla.kernel.org/show_bug.cgi?id=6275
> 
> ian@beware.dropbear.id.au (Ian Dall):
> 
> The command sent to the card was using a 30second timeout regardless of the
> timeout requested in the scsi command passed down from higher levels.
> 
> Signed-off-by: Jes Sorensen <jes@sgi.com>

Signed-off-by: Ian Dall <ian@beware.dropbear.id.au>
> 
> ---
>  drivers/scsi/qla1280.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/scsi/qla1280.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/qla1280.c
> +++ linux-2.6/drivers/scsi/qla1280.c
> @@ -2864,7 +2864,7 @@ qla1280_64bit_start_scsi(struct scsi_qla
>  	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
>  
>  	/* Set ISP command timeout. */
> -	pkt->timeout = cpu_to_le16(30);
> +	pkt->timeout = cpu_to_le16(cmd->timeout_per_command/HZ);
>  
>  	/* Set device target ID and LUN */
>  	pkt->lun = SCSI_LUN_32(cmd);
> @@ -3163,7 +3163,7 @@ qla1280_32bit_start_scsi(struct scsi_qla
>  	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
>  
>  	/* Set ISP command timeout. */
> -	pkt->timeout = cpu_to_le16(30);
> +	pkt->timeout = cpu_to_le16(cmd->timeout_per_command/HZ);
>  
>  	/* Set device target ID and LUN */
>  	pkt->lun = SCSI_LUN_32(cmd);
-- 
Ian Dall <ian@beware.dropbear.id.au>

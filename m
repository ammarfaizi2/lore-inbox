Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWGSBxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGSBxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWGSBxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:53:41 -0400
Received: from in.cluded.net ([195.159.98.120]:18565 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S932459AbWGSBxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:53:40 -0400
Message-ID: <44BD8FB7.9080307@cluded.net>
Date: Wed, 19 Jul 2006 01:49:43 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org, linux-eata@i-connect.net
Subject: Re: [PATCH 2/2] Forgotten memset
References: <20060719013407.GG30823@lumumba.uhasselt.be>
In-Reply-To: <20060719013407.GG30823@lumumba.uhasselt.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> --- a/drivers/scsi/ide-scsi.c
> +++ b/drivers/scsi/ide-scsi.c
> @@ -327,7 +327,7 @@ static int idescsi_check_condition(ide_d
>  
>  	/* stuff a sense request in front of our current request */
>  	pc = kzalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
> -	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
> +	rq = kzalloc (sizeof (struct request), GFP_ATOMIC);
>  	buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
>  	if (pc == NULL || rq == NULL || buf == NULL) {
>  		kfree(buf);
>
> Was this forgotten and therefore, is it necessary or useful to zero this
> out?

No, this code snippet is followed by a call to

	ide_init_drive_cmd(rq)

which calls memset()


Daniel K.


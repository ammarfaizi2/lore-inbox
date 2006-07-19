Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWGSGWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWGSGWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 02:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWGSGWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 02:22:34 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:9667 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932514AbWGSGWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 02:22:33 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] Conversions from kmalloc+memset to k(z|c)alloc
Date: Wed, 19 Jul 2006 08:23:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-eata@i-connect.net
References: <20060719013113.GF30823@lumumba.uhasselt.be>
In-Reply-To: <20060719013113.GF30823@lumumba.uhasselt.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607190823.39571.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added linux-scsi to CC as it touches drivers/scsi/

>  	/* stuff a sense request in front of our current request */
> -	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
> +	pc = kzalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);

Please remove the space before the arguments.

>  	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);

This and the one before should be "rq = kzalloc(sizeof(*rq),...);" This way 
you will always get the correct buffer size even if the type of rq changes.

Eike

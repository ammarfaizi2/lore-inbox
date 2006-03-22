Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWCVSAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWCVSAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCVSAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:00:44 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:23519 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932266AbWCVSAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:00:42 -0500
Message-ID: <442190C2.6040001@oracle.com>
Date: Wed, 22 Mar 2006 10:00:34 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Subject: Re: [patch] add private data to notifier_block
References: <1142970154.31210.10.camel@whizzy>
In-Reply-To: <1142970154.31210.10.camel@whizzy>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi wrote:

> device data can be easily accessed.  This patch will modify the
> notifier_block struct to add a void *, and will require no modifications
> to any other users of the notifier_block.

>  {
>  	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
>  	struct notifier_block *next;
> +	void *data;
>  	int priority;
>  };

Well, it might introduce warnings in users who weren't using named
initializers -- their bare priority initialization might now shift to
trying to initialize a pointer.

Though, that's probably a good thing as it gives an opportunity to
convert them.  We also don't want to create a padded structure by
putting the void * after the int.

- z

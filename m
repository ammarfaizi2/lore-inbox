Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTICW6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTICW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:58:44 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55731 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264165AbTICW6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:58:43 -0400
Date: Thu, 4 Sep 2003 00:53:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: mike.miller@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss error handling patch for 2.6.0-test4
Message-ID: <20030904005318.A14780@electric-eye.fr.zoreil.com>
References: <20030903223347.GA11071@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030903223347.GA11071@beardog.cca.cpqcorp.net>; from mike.miller@hp.com on Wed, Sep 03, 2003 at 05:33:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com <mike.miller@hp.com> :
> This patch was built & tested using 2.6.0-test4. It _hopefully_ cleans up the error handling in cciss_init_one().
> Please consider this for inclusion in the 2.6.0 kernel.

[...]
> +clean4:
> +	if(hba[i]->cmd_pool_bits)
> +               	kfree(hba[i]->cmd_pool_bits);
> +	if(hba[i]->cmd_pool)
> +		pci_free_consistent(hba[i]->pdev,
> +			NR_CMDS * sizeof(CommandList_struct),
> +			hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
> +	if(hba[i]->errinfo_pool)
> +		pci_free_consistent(hba[i]->pdev,
> +			NR_CMDS * sizeof( ErrorInfo_struct),
> +			hba[i]->errinfo_pool, 
> +			hba[i]->errinfo_pool_dhandle);
> +clean3:
> +	free_irq(hba[i]->intr, hba[i]);
> +clean2:
> +	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
> +clean1:
> +	release_io_mem(hba[i]);
> +clean0:
> +	free_hba(i);
> +	return(-1);
>  }

Would you mind to change the cleanX exit labels to more descriptive names ?
Say err_free_hba, err_free_irq for example.

Moreover, note that the same tests (the "if"s) are done twice.

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVIQJ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVIQJ35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVIQJ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 05:29:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34507 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751015AbVIQJ34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 05:29:56 -0400
Date: Sat, 17 Sep 2005 10:29:53 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: How to avoid "Trying to register duplicated ioctl32 handler"
Message-ID: <20050917092953.GA14144@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD194@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CD194@exa-atlanta>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 05:17:29PM -0400, Bagalkote, Sreenivas wrote:
> In our MegaRAID driver, one of the IOCTLs is defined as
> #define MEGASAS_IOC_GET_AEN _IOW('M', 2, struct megasas_aen)
> 
> This clashes with some other value in "built_in" ioctl table on x86_64
> kernels.
> How do I really avoid such problems in the future. Even if I search the
> length
> of the built_in table and pick a unique value, is it guaranteed to be unique
> in
> the future releases? The Documentation/ioctl-number.txt isn't of much help
> either.
> It lists multiple conflicts. Moreover, not all of them are listed there.
> 
> On a broader note, if the struct ioctl_trans inside ioctl32_hash_table could
> use the combination of cmd + major number instead of just cmd to determine
> the
> uniqueness, these conflicts could be avoided, right? I mean understand the
> reasons
> for system-wide unique ioctl numbers. But right now, only those platforms
> that
> need conversion are technically impeded for violating that guideline.

Cou can't avoid the clashes in the hash.  That's why we got rid of
user-registerable ioctl translations completely and only allow ->compat_ioctl
anymore.

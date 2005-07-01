Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263201AbVGACeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbVGACeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 22:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVGACeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 22:34:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263201AbVGACdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 22:33:04 -0400
Date: Thu, 30 Jun 2005 22:32:26 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
In-Reply-To: <20050630195043.GE23538@serge.austin.ibm.com>
Message-ID: <Xine.LNX.4.44.0506302228390.18881-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005 serue@us.ibm.com wrote:

> +/* list modules */
> +static ssize_t listmodules_read (struct stacker_kobj *obj, char *buff)
> +{
> +	ssize_t len = 0;
> +	struct module_entry *m;
> +
> +	rcu_read_lock();
> +	stack_for_each_entry(m, &stacked_modules, lsm_list) {
> +		len += snprintf(buff+len, PAGE_SIZE - len, "%s\n",
> +			m->module_name);
> +	}
> +	rcu_read_unlock();
> +
> +	return len;
> +}
> +

As far as I'm aware, sysfs nodes are supposed to contain one entity per 
file.  Not sure what the alternative here is, though.


- James
-- 
James Morris
<jmorris@redhat.com>



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVARGo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVARGo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 01:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVARGo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 01:44:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:20453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261237AbVARGoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 01:44:23 -0500
Date: Mon, 17 Jan 2005 22:44:01 -0800
From: Greg KH <greg@kroah.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com,
       Nathan Lynch <nathanl@austin.ibm.com>, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050118064401.GA9529@kroah.com>
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E70234.50900@gmail.com> <20050113233446.GA2710@kroah.com> <41EBEE98.7090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EBEE98.7090207@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 05:58:00PM +0100, Luca Falavigna wrote:
> +static ssize_t kprobes_read(struct file *file, char __user *buf,
> +			 size_t size, loff_t *off)
> +{
> +	int i;
> +	char *data = "";
> +	ssize_t len = 0;
> +	struct hlist_node *node;
> +	struct kprobe *k;
> +	
> +	spin_lock(&kprobe_lock);
> +	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
> +		hlist_for_each_entry(k, node, &kprobe_table[i], hlist) {
> +			if(k) {
> +				kprobes_list_info(k, data + len);
> +				len += strlen(data);
> +			}
> +		}
> +	}
> +	spin_unlock(&kprobe_lock);
> +	return simple_read_from_buffer(buf, size, off, data, len);

Am I missing where you allocate the space for the data to be put into?

Also, why not use the seqfile interface for this, to prevent overflowing
the read buffer?

thanks,

greg k-h

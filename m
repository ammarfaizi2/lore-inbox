Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDZGqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDZGqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDZGqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:46:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12692 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261349AbVDZGqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:46:03 -0400
Date: Tue, 26 Apr 2005 14:49:40 +0800
From: David Teigland <teigland@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 4/7] dlm: configuration
Message-ID: <20050426064940.GE12096@redhat.com>
References: <20050425151250.GE6826@redhat.com> <Pine.LNX.4.62.0504251749090.2941@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504251749090.2941@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 05:53:49PM +0200, Jesper Juhl wrote:
> On Mon, 25 Apr 2005, David Teigland wrote:

> > +static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
> > +{
> > +	ls->ls_global_id = simple_strtol(buf, NULL, 0);
> > +	return len;
> > +}
>
> What's the point of `len' in these two functions? 
> You pass in `len`, don't use it at all, then return the value. I fail to 
> see the usefulness. Why not just have the function return void and omit 
> the `len' parameter?

Do I have a choice?  Aren't these stipulated by sysfs?

static ssize_t dlm_attr_store(struct kobject *kobj, struct attribute *attr,
                              const char *buf, size_t len)
{
        struct dlm_ls *ls  = container_of(kobj, struct dlm_ls, ls_kobj);
        struct dlm_attr *a = container_of(attr, struct dlm_attr, attr);
        return a->store ? a->store(ls, buf, len) : len;
}

static struct sysfs_ops dlm_attr_ops = {
        .show  = dlm_attr_show,
        .store = dlm_attr_store,
};

Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWB0QIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWB0QIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWB0QIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:08:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751264AbWB0QIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:08:42 -0500
Message-ID: <4403244D.2080700@ce.jp.nec.com>
Date: Mon, 27 Feb 2006 11:09:49 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (common)
 (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D8C.1060904@ce.jp.nec.com> <20060222184853.GB13638@suse.de> <43FCE40A.1010206@ce.jp.nec.com> <20060222222846.GA14249@suse.de> <43FE09E1.4080907@ce.jp.nec.com> <20060224034007.GA2769@suse.de>
In-Reply-To: <20060224034007.GA2769@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the comments.

Greg KH wrote:
>>+static inline struct kobject *add_dir(struct kobject *parent, const char *name)
>>+{
>>+	struct kobject *k;
>>+
>>+	if (!parent)
>>+		return NULL;
>>+
>>+	k = kmalloc(sizeof(*k), GFP_KERNEL);
>>+	if (!k)
>>+		return NULL;
>>+
>>+	memset(k, 0, sizeof(*k));
>>+	k->parent = parent;
>>+	k->ktype = &dir_ktype;
>>+	kobject_set_name(k, name);
>>+	kobject_register(k);
>>+
>>+	return k;
>>+}
> 
> This code looks good enough that we should add it to the core kobject
> code, don't you think?  Also, you might use kzalloc instead of kmalloc
> here.

Yes, it would be nice if kobject core has this function.
I'll move them to lib/kobject.c.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

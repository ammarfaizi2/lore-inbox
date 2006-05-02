Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWEBI4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWEBI4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWEBI4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:56:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5836 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932517AbWEBI4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:56:50 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       clg@us.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<20060501203907.XF1836@sergelap.austin.ibm.com>
	<1146515316.32079.27.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 02:55:40 -0600
In-Reply-To: <1146515316.32079.27.camel@localhost.localdomain> (Dave
 Hansen's message of "Mon, 01 May 2006 13:28:36 -0700")
Message-ID: <m1veso7qlv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Mon, 2006-05-01 at 14:53 -0500, Serge E. Hallyn wrote:
>> +struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
>> +{
>> +	struct uts_namespace *ns;
>> +
>> +	ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
>> +	if (ns) {
>> +		memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
>> +		kref_init(&ns->kref);
>> +	}
>> +	return ns;
>> +}
>
> Very small nit...
>
> Would this memcpy be more appropriate as a strncpy()?

Nope.  It is several strings.  Although a different field name
for the old utsname structure might be called for to keep people
from getting confused.

Eric

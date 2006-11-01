Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946685AbWKAIDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946685AbWKAIDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946688AbWKAIDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:03:00 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:25362 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946685AbWKAIC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:02:58 -0500
Message-ID: <454853B2.8020604@openvz.org>
Date: Wed, 01 Nov 2006 10:58:42 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, vatsa@in.ibm.com,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>	 <6599ad830610301001i2ad35290u63839e920d82a5f4@mail.gmail.com>	 <454709E0.1000409@openvz.org> <6599ad830610310834g12a66aan29b568d7f9a5525@mail.gmail.com>
In-Reply-To: <6599ad830610310834g12a66aan29b568d7f9a5525@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 10/31/06, Pavel Emelianov <xemul@openvz.org> wrote:
>>
>> That's functionality user may want. I agree that some users
>> may want to create some kind of "persistent" beancounters, but
>> this must not be the only way to control them. I like the way
>> TUN devices are done. Each has TUN_PERSIST flag controlling
>> whether or not to destroy device right on closing. I think that
>> we may have something similar - a flag BC_PERSISTENT to keep
>> beancounters with zero refcounter in memory to reuse them.
> 
> How about the cpusets approach, where once a cpuset has no children
> and no processes, a usermode helper can be executed - this could

Hmm... Sounds good. I'll think over this.

> immediately remove the container/bean-counter if that's what the user
> wants. My generic containers patch copies this from cpusets.
> 
>>
>> Moreover, I hope you agree that beancounters can't be made as
>> module. If so user will have to built-in configfs, and thus
>> CONFIG_CONFIGFS_FS essentially becomes "bool", not a "tristate".
> 
> How about a small custom filesystem as part of the containers support,
> then? I'm not wedded to using configfs itself, but I do think that a
> filesystem interface is much more debuggable and extensible than a
> system call interface, and the simple filesystem is only a couple of
> hundred lines.

This sounds more reasonable than using configfs for me.

> Paul
> 


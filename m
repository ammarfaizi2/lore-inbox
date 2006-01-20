Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161389AbWATFMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161389AbWATFMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161501AbWATFMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:12:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60611 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161389AbWATFMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:12:16 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
References: <20060117143258.150807000@sergelap> <43CD18FF.4070006@FreeBSD.org>
	<1137517698.8091.29.camel@localhost.localdomain>
	<43CD32F0.9010506@FreeBSD.org>
	<1137521557.5526.18.camel@localhost.localdomain>
	<1137522550.14135.76.camel@localhost.localdomain>
	<1137610912.24321.50.camel@localhost.localdomain>
	<1137612537.3005.116.camel@laptopd505.fenrus.org>
	<1137613088.24321.60.camel@localhost.localdomain>
	<1137624867.1760.1.camel@localhost.localdomain>
	<1137654906.2993.10.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 19 Jan 2006 22:11:18 -0700
In-Reply-To: <1137654906.2993.10.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Thu, 19 Jan 2006 08:15:06 +0100")
Message-ID: <m1k6cvo555.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Wed, 2006-01-18 at 22:54 +0000, Alan Cox wrote:
>> On Mer, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
>> > But, it seems that many drivers like to print out pids as a unique
>> > identifier for the task.  Should we just let them print those
>> > potentially non-unique identifiers, deprecate and kill them, or provide
>> > a replacement with something else which is truly unique?
>> 
>> Pick a format for container number + pid and document/stick with it -
>> something like container::pid (eg 0::114) or 114[0] whatever so long as
>> it is consistent
>
> having a pid_to_string(<task struct>) or maybe task_to_string() thing
> for convenient printing of pids/tasks.. I'm all for that. Means you can
> even configure how verbose you want it to be (include ->comm or not,
> ->state maybe etc)

The only way I can see to sanely do this is to pass it the temporary
buffer it writes it's contents into.
Something like:
printk(KERN_XXX "%s\n", task_to_string(buf, tsk)); ?


Eric

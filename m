Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWATUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWATUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWATUd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:33:56 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29146 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932170AbWATUdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:33:55 -0500
Message-ID: <43D14931.7010305@watson.ibm.com>
Date: Fri, 20 Jan 2006 15:33:53 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
References: <1137517698.8091.29.camel@localhost.localdomain> <43CD32F0.9010506@FreeBSD.org> <1137521557.5526.18.camel@localhost.localdomain> <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <1137654906.2993.10.camel@laptopd505.fenrus.org> <m1k6cvo555.fsf@ebiederm.dsl.xmission.com> <20060120202339.GB13265@sergelap.austin.ibm.com>
In-Reply-To: <20060120202339.GB13265@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
>>Arjan van de Ven <arjan@infradead.org> writes:
>>
>>
>>>On Wed, 2006-01-18 at 22:54 +0000, Alan Cox wrote:
>>>
>>>>On Mer, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
>>>>
>>>>>But, it seems that many drivers like to print out pids as a unique
>>>>>identifier for the task.  Should we just let them print those
>>>>>potentially non-unique identifiers, deprecate and kill them, or provide
>>>>>a replacement with something else which is truly unique?
>>>>
>>>>Pick a format for container number + pid and document/stick with it -
>>>>something like container::pid (eg 0::114) or 114[0] whatever so long as
>>>>it is consistent
>>>
>>>having a pid_to_string(<task struct>) or maybe task_to_string() thing
>>>for convenient printing of pids/tasks.. I'm all for that. Means you can
>>>even configure how verbose you want it to be (include ->comm or not,
>>>->state maybe etc)
>>
>>The only way I can see to sanely do this is to pass it the temporary
>>buffer it writes it's contents into.
>>Something like:
>>printk(KERN_XXX "%s\n", task_to_string(buf, tsk)); ?
> 
> 
> That's kind of neat :)
> 
> The only other thing I can think of is to do something like
> 
> #define task_str(tsk) tsk->container_id, tsk->pid
> or
> #define task_str(tsk) tsk->container_id, ":", tsk->pid
> 
> and have it be used as
> 
> printk(KERN_XXX "%s::%s\n", task_str(tsk));
> or
> printk(KERN_XXX "%s%s%s\n", task_str(tsk));
> 
> The only reason I point it out is that we don't risk memory corruption
> if the printk caller forgets to give the extra '%s's, like we do if
> the caller forgets they need char buf[PID_CONTAINER_MAXLENGTH] instead
> of 'char *buf;' or 'char buf;'.
> 
> -serge
> 

As odd as this looks .. it does have the benefits and anything that avoids
potential problems.

On the other hand you might run into problems with the following.

		char *str = task_str(tsk);

Eitherway .. I don't think these are the big fish to fry now :-)

-- Hubertus


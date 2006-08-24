Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWHXO4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWHXO4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHXO4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:56:05 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:32100 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932243AbWHXO4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:56:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XOD259I4o5gkPI56QAQMIHVDLVZ1sg9/Q/49mu+gknjBisA/fJ7JmmBaTvmOgrjqDVhxQlf4vlMj7va89M/MV69s72hswYQxeTp7u6zMZ1DBe3bDQcdGm2oLyHky0CL0X0LKj+XOQ3QMygYElsYGPxKiSdLxwysz7i7WVSUdqvw=  ;
Message-ID: <44EDBDDE.7070203@yahoo.com.au>
Date: Fri, 25 Aug 2006 00:55:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: ego@in.ibm.com, rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
References: <20060824103417.GE2395@in.ibm.com>	 <1156417200.3014.54.camel@laptopd505.fenrus.org>	 <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1156429015.3014.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-08-24 at 19:33 +0530, Gautham R Shenoy wrote:
> 
>>On Thu, Aug 24, 2006 at 01:00:00PM +0200, Arjan van de Ven wrote:
>>
>>>On Thu, 2006-08-24 at 16:04 +0530, Gautham R Shenoy wrote:
>>>
>>>>
>>>>This patch renames lock_cpu_hotplug to cpu_hotplug_disable and
>>>>unlock_cpu_hotplug to cpu_hotplug_enable throughout the kernel.
>>>
>>>Hi,
>>>
>>>to be honest I dislike the new names too. You turned it into a refcount,
>>>which is good, but the normal linux name for such refcount functions is
>>>_get and _put.....  and in addition the refcount technically isn't
>>>hotplug specific, all you want is to keep the kernel data for the
>>>processor as being "used", so cpu_get() and cpu_put() would sound
>>>reasonable names to me, or cpu_data_get() cpu_data_put().
>>
>>Thus, choice of 'cpu_hotplug_disable' and 'cpu_hotplug_enable'
>>was determined on the basis of its purpose, as in *what* it does 
>>as opposed to *how* it does it. :)
> 
> 
> well.. it comes down to the difference of locking to protect data versus
> locking to protect against a specific piece of code. Almost always the
> later turns out to be a mistake...

But it is not protecting a cpu from going away, it is protecting ALL
cpus from coming or leaving. In that respect it is much more like a
cpu_online_map lock rather than a data structure refcount.

It really is just like a reentrant rw semaphore... I don't see the
point of the name change, but I guess we don't like reentrant locks so
calling it something else might go down better with Linus ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWBGUqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWBGUqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBGUqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:46:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46795 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750879AbWBGUqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:46:20 -0500
Message-ID: <43E90716.4020208@watson.ibm.com>
Date: Tue, 07 Feb 2006 15:46:14 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com>
In-Reply-To: <20060207201908.GJ6931@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Hubertus Franke (frankeh@watson.ibm.com):
> 
>>The vpid approach has the drawbacks of having to identify the conversion 
>>spots
>>of all vpid vs. pid semantics. On the otherhand it does take advantage
>>of the fact that no virtualization has to take place until a "container"
>>has been migrated, thus rendering most of the vpid<->pid calls to be
>>noops.
>>
>>What I like about the pspace approach is that it explicitely defines in the 
>>code
>>when I am using a different pspace for the lookup. That is kind of hidden in
>>the vpid/pid approach.
> 
> 
> I agree with this.  From a maintenance pov, imagining making a minor
> change to some pid-related code, if I see something doing effectively
> "if (pspace1 == pspace2 && pid1==pid2)" that is clear, whereas trying
> to remember whether I'm supposed to return the pid or vpid can get
> really confusing.  We actually had some errors with that while we were
> developing the first vpid patchset we posted in december.
> 
> I believe that from a vserver point of view, either approach will work.
> You either create a new pspace and make 'init' pid 1 in that pspace, or,
> in the openvz approach, you start virtualizing with a hashtable so
> userspace in the new vserver/container/vz/whateveritscalled sees that
> init as pid1, while the rest of the system sees it as pid 3270 or
> something.
> 
> Likewise, for checkpoint/restore and migration, either approach works.
> All we really need is, on restore/migrate, to be able to create
> processes with their original pids, so we can do that either with real
> pids in a new container, or virtualized pids faked for process in the
> same vz.
> 
> Are there other uses of pid virtualization which one approach or the
> other cannot accomodate?

Kirill brought up that VPS can span a cluster..
if so how do you (Kirill) do that? You pre-partition the pids into allocation
ranges for each container?
Eitherway, if this is an important feature, then one needs to look at
how that is achieved in pspace (e.g. mod the pidmap_alloc() function
to take legal ranges into account). Should still be straight forward.

> 
> If not, then I for one lean towards the more maintainable code.  (which
> I'm sure we're not agreed on is Eric's, but imvho it is)
> 
> -serge
> 



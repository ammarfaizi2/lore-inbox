Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVEZBVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVEZBVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEZBVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:21:13 -0400
Received: from Boole.cs.uh.edu ([129.7.240.11]:12520 "EHLO boole.cs.uh.edu")
	by vger.kernel.org with ESMTP id S261646AbVEZBUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:20:43 -0400
Message-ID: <32880.129.7.248.115.1117070442.squirrel@129.7.248.115>
Date: Wed, 25 May 2005 20:20:42 -0500 (CDT)
Subject: autofs problem on rocks cluster with 2.6.12-rc4-mm2
From: "Deepti Vyas" <dvyas@cs.uh.edu>
To: linux-kernel@vger.kernel.org
Reply-To: dvyas@cs.uh.edu
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know of any similar problems and fixes?

Here is the problem description for Autofs after we install 2.6.12-rc4-mm2:


> on the compute node with 2.6.12 kernel I found that
>
> #demsg  show following error info.
>
> audit(1117060783.329:0): avc:  denied  { name_connect } for  dest=80
scontext=user_u:system_r:unconfined_t
> tcontext=system_u:object_r:http_port_t tclass=tcp_socket
>
> While on the nodes with 2.6.9 kernel, no such error message.
>
> This means frontend port 80 is close for the compute node with 2.6.12-mm
 kernel.
> After test on 2 nodes, following is what I got.
>
> [root@compute-0-1 ~]# telnet 192.168.1.250 80
> Trying 192.168.1.250...
> telnet: connect to address 192.168.1.250: Permission denied
> telnet: Unable to connect to remote host: Permission denied
>
> [root@compute-0-0 ~]# telnet 192.168.1.250 80
> Trying 192.168.1.250...
> Connected to grid11.local (192.168.1.250).
> Escape character is '^]'.
> ^]
> telnet> exit
> ?Invalid command
> telnet> quit
> Connection closed.
>
> But on the frontend, iptables has no rule on private interface.
>
>> Looks like one of the compute nodes is advertising itself at the 411
master. is 192.168.1.250 a compute node's IP??
>>
>> Follow the instructions from here:
>>
>> https://lists.sdsc.edu/pipermail/npaci-rocks-discussion/2004-July/006745.html
>>
>> Just installing the kernel RPMs under
>> /home/install/contrib/enterprise/4/public/i386/RPMS/ is not sufficient.
Did you add the kernel's entry in extend-compute.xml??
>>
>>
>>>
>>> This is post following my "snmpd.conf & mount /home problem " post.
>>>
>>> I think it is the autofs and 411 problem.
>>>
>>> cd /var/411
>>>
>>> [root@grid11 411]# make
>>> make: Nothing to be done for `all'.
>>>
>>> [root@grid11 411]# cluster-fork "/opt/rocks/bin/411get --all"
>>> compute-0-0:
>>> Wrote: /etc/rpc
>>> Wrote: /etc/group
>>> Wrote: /etc/shadow
>>> Wrote: /etc/auto/misc
>>> Wrote: /etc/auto/master
>>> Wrote: /etc/passwd
>>> Wrote: /etc/auto/home
>>> Wrote: /etc/auto/net
>>> Wrote: /etc/services
>>> compute-0-1:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-2:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-3:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-4:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-5:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-6:
>>> Wrote: /etc/rpc
>>> Wrote: /etc/group
>>> Wrote: /etc/shadow
>>> Wrote: /etc/auto/misc
>>> Wrote: /etc/auto/master
>>> Wrote: /etc/passwd
>>> Wrote: /etc/auto/home
>>> Wrote: /etc/auto/net
>>> Wrote: /etc/services
>>> compute-0-7:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-8:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>> compute-0-9:
>>> Error: Could not reach a master server. Masters:
>>> [http://192.168.1.250/411.d/ (-1)]
>>>
>>> Actually compute-0-6 and compute-0-0 boot up with the default 2.6.9
kernel.
>>> all the others use the 2.6.12 kernel.
>>>
>>> By the way, I also try and build 2.6.11.10 kernel, works fine no
problem at all.
>>> Will this be the kernel's problem? But I use the same .config file
when build the rpm.
>>>
>>> One more thing is I put both kernel 2.6.11 and 2.6.12-rc4-mm2  rpm
under /home/install/contrib/enterprise/4/public/i386/RPMS/
>>> I hope I could get 3 kernels installed on the compute node, but only
2.6.9 and 2.6.12 are installed.
>>> Will this introduce some conflict? Or Rocks only use the newest kernel
in that /RPMS directory.
>>>
>>>



> On Tue, 24 May 2005 09:04 am, Deepti Vyas wrote:
>> I tried using 2.6.11.10 with patch-2.6.11-smpnice-1.diff.
>
> It partially worked but some bugs were present and it has been resynced
with
> the latest -mm kernel. Can you try
> http://ck.kolivas.org/patches/smpnice/patch-2.6.12-rc4-mm2-smpnice-1.diff
on top of
> linux-2.6.12-rc4-mm2
>
> Cheers,
> Con
>
> P.S. please don't email me 3 different ways and separate the mailing
list email from the personal ones and so on. One copy cc'ed to relevant
places is
> enough :|
>





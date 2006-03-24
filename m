Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWCXRXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWCXRXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWCXRXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:23:49 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:53426 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S932486AbWCXRXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:23:48 -0500
Message-ID: <44242B1B.1080909@sw.ru>
Date: Fri, 24 Mar 2006 20:23:39 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, sam@vilain.net
Subject: [RFC] Virtualization patches for IPC/UTS. 2nd step
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I propose to consider these patches for utsname and sysv IPC 
virtualization once more.

The main change from the previous version is an introduction of separate 
namespaces for each subsytem as suggested by Eric Biederman. People who 
work on containers don't care actually, so I splitted a container into 
namespaces.

The naming conventions used in these patches are (as example for IPC):

CONFIG_IPC_NS		- per namespace config option
struct ipc_namespace	- structure describing namepsace
ipc_ns			- names of var pointers, in task_struct etc.
init_ipc_ns		- default host namespace

interfaces:
get_ipc_ns		- refcountig interface
put_ipc_ns		- refcountig interface
create_ipc_ns		- create _empty_ namespace
clone_ipc_ns		- clone current namespace, if applicable
free_ipc_ns		- destroy namespace when refs are 0

Please, note, these patches do not introduce CONFIG_XXX_NS option in any 
of Kconfigs, as it is questionable whether to have them scattered all 
around or place in some menu "Virtual namespaces". But patches compile 
and work fine both w/o and with it.

Also, please, note, that these patches do not virtualize corresponding 
sysctls or proc parts of uts/ipc. I suppose this must be postponed as we 
have no any consensus on /proc.

Some other minor differences from Eric/Dave patches:
- these patches heavily use current namespace context instead of
   bypassing additional argument to all functions where required.
- these patches compile to the old good kernel when namespaces are off.

Both patches are also available in GIT repo at:
http://git.openvz.org/pub/linux-2.6-openvz-ms/

Thanks,
Kirill


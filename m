Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWDTROv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDTROv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDTROv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:14:51 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:21253 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751182AbWDTROu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:14:50 -0400
Message-ID: <4447C31B.1080000@openvz.org>
Date: Thu, 20 Apr 2006 21:21:31 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Kir Kolyshkin <kir@openvz.org>, Dmitry Mishin <dim@openvz.org>
Subject: [ANNOUNCE] OpenVZ releases checkpointing/live migration of processes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

OpenVZ team is proud to announce the release of the new 
checkpointing/restore feature. This feature allows to save (checkpoint) 
and restore the whole state of a Virtual Environment (VE, container) and 
do a live migration of a VE to another physical box while preserving 
process states and TCP/IP connections.

During live migration the in-kernel state of processes and their 
resources (including memory, registers, IPC, pids, open files, sockets, 
etc.) is saved and then restored on another machine. Since all network 
connections are preserved with all the in-progess requests, user doesn't 
experience interruption of service.

The feature is available on i686 and x86_64 architectures. Migration of 
32bit VEs between i686 and x86_64 architectures is also supported.
Current implementation works fine with complex applications like Oracle, 
Java, X apps.

Latest 2.6.16 OpenVZ kernel and tool packages with live migration 
support are available here:
http://openvz.org/download/beta/kernel/
http://openvz.org/download/utils/

GIT repository for all OpenVZ sources is available at
http://git.openvz.org/

Usage examples
~~~~~~~~~~~~~~

New 'vzmigrate' utility is used for VE migration. Also, new commands for 
'vzctl' allowing to dump and restore VE were introduced: 'chkpnt' and 
'restore'.

To save current VE state with all processes:
# vzctl chkpnt <VEID>

To restore VE after checkpointing:
# vzctl restore <VEID>

To perform online migration of VE #101 to another machine:
# vzmigrate --online destination.node.com 101
without '--online' option vzmigrate does offline VE migration with VE 
start/stop.

With best regards,
OpenVZ team.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVCWE36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVCWE36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVCWE36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:29:58 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:19590 "HELO
	ns.intellilink.co.jp") by vger.kernel.org with SMTP id S261469AbVCWE3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:29:46 -0500
Subject: Re: Query: Kdump: Core Image ELF Format
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: vivek goyal <vgoyal@in.ibm.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A?= =?UTF-8?Q?=E7=A4=BE?=
Date: Wed, 23 Mar 2005 13:26:57 +0900
Message-Id: <1111552017.3604.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

On Tue, 2005-03-08 at 18:20 +0530, vivek goyal wrote:
> Core image ELF headers are prepared before crash and stored at a safe
> place in memory. These headers are retrieved over a kexec boot and final
> elf core image is prepared for analysis. 

Regarding the preparation of the ELF headers, I think we should also
take into consideration hot-plug memory and create appropriate
mechanisms to deal with it.

Assuming that both insertion and removal of memory trigger a hotplug
event that is subsequently handled by the relevant hotplug agent(*), the
latter could be modified so that, on successful memory onlining,
additional PT_LOAD headers are created and tucked in a safe place
together with the others.

Since ELF headers are to be prepared by kexec a new option could be
added to it, so that we can call kexec from a hotplug script to carry
out the aforementioned tasks.

Any thoughts or suggestions on this?

(*) The last patches posted by Dave Hansen already support memory
onlining from an /etc/hotplug script.

Fernando



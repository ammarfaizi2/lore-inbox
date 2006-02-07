Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWBGJqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWBGJqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWBGJqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:46:37 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:18170 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S964824AbWBGJqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:46:36 -0500
Message-ID: <43E86C73.2070608@fr.ibm.com>
Date: Tue, 07 Feb 2006 10:46:27 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <43E38D40.3030003@fr.ibm.com> <20060206094843.GA6013@ms2.inr.ac.ru> <20060206145104.GB11887@sergelap.austin.ibm.com> <20060206155101.GA22522@ms2.inr.ac.ru>
In-Reply-To: <20060206155101.GA22522@ms2.inr.ac.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov wrote:

> The question was not about openvz, it was about (container,pid) approach.
> How are you going to reap chidren without a child reaper inside container?
> If you reparent all the children to a single init in root container,
> what does wait() return? In openvz it returns global pid and child is buried
> in peace. If you do not have global pid, you cannot just return private pid.

I think the "child reaper" question is not related to the (container,pid)
approach or the vpid approach. This is another question on who is the
parent of a container and how does it behaves.

We have choosen to first follow a simple "path", complete pid isolation
being the main constraint : a container is created by exec'ing a process in
it. That first process is detached from its parent processes and becomes
child of init (already running), session leader, and process group leader.
We could eventually add a daemon to act as a init process for the container.

Now, there are other ways of seeing a container parenthood, openvz, eric,
vserver, etc. We should agree on this or find a way to have different model
cohabitate.

C.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWJEK2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJEK2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWJEK2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:28:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:49235 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751592AbWJEK2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:28:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yf+L3t1bNS5fU/y0Zcq3DHZu4rtd1Jy3SiVxFfIUHL21agTjv6Rn1fm5FGSKQboLw4fNXug/aY5Q1J7LyXKBIqZAjikTfb5KC9Dbzf2Ehr6IsK6IkxjqcV44+tkJ0uiEA4sC/J8VO6x6glu9s0ebb23txyR/WQ3hRCVk3aytxfQ=
Message-ID: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com>
Date: Thu, 5 Oct 2006 19:28:35 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc1: kexec broken on x86_64
Cc: fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Vivek Goyal" <vgoyal@in.ibm.com>, Horms <horms@verge.net.au>,
       "Magnus Damm" <magnus@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec is broken on x86_64 under 2.6.19-rc1.

Or rather - kexec works ok under 2.6.19-rc1, but something related to
the vmlinux format has probably changed and kexec-tools fails to load
a vmlinux from 2.6.19-rc1.

Loading bzImage works as usual, but vmlinux does not load properly.

The kexec binary fails with the following message:

Overlapping memory segments at 0x351000
sort_segments failed
/ #

Again, running kexec under 2.6.19-rc1 works ok. But rebooting into a
2.6.19-rc1 vmlinux does not work correctly. This is regardless of
which kexec-tools tree used.

A coarse-grained bisect says that the problem was introduced in 2.6.18-git7.

But maybe this is a kexec-tools issue?

I've used Horms testing tree as usual, tested the latest version
5aa1e11a27f1dc1ce96f850966e94f68c9cd8bce to be exact. Horms testing
tree that can be found here:

http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=summary

I've also tried version 71d2424c8ac4f93a60c3eee5c95df269f584a9da of
Eric's main tree:

http://www.kernel.org/git/?p=linux/kernel/git/ebiederm/kexec-tools.git;a=summary

That tree is unfortunately broken on x86_64. You need to apply the
follwing patch on x86_64 to be able to compile:

http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=commit;h=6492b850281a106c042221b836a693141fd9b49b

None of the kexec-tools trees can load a 2.6.19-rc1 vmlinux under
x86_64. i386 works fine.

/ magnus

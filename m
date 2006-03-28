Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWC1LrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWC1LrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWC1LrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:47:10 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:40167 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932189AbWC1LrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:47:08 -0500
Date: Tue, 28 Mar 2006 13:48:13 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328134813.42f831e3@localhost>
In-Reply-To: <20060328112241.40b9c975@localhost>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
	<20060328004137.607e51db.akpm@osdl.org>
	<20060328112241.40b9c975@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 11:22:41 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> Maybe I should retry with 2.6.16 and if I can reproduce the problem I
> can start testing 2.6.16-rc1 and so on...

Reproduced with 2.6.16...

"TESTCASE" (I'm on Gentoo)
ebuild /usr/portage/x11-libs/qt/qt-4.1.1.ebuild clean
ebuild /usr/portage/x11-libs/qt/qt-4.1.1.ebuild compile


# time ./TESTCASE

...

g++ -c -m64 -pipe -march=athlon64 -O2 -pipe -Wall -W -D_REENTRANT  -DQT_KEYWORDS -DQT_NO_DEBUG -DQT_XML_
LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE -DQT_SHARED -I
../../mkspecs/linux-g++-64 -I. -I../../include/QtCore -I../../include/QtNetwork -I../../include/QtGui -I
../../include/QtXml -I../../include -I.moc/release-shared -I. -o .obj/release-shared/docuparser.o docupa
rser.cpp
/var/tmp/portage/qt-4.1.1/work/qt-x11-opensource-src-4.1.1/bin/uic settingsdialog.ui -o ui_settingsdialo
g.h
g++ -c -m64 -pipe -march=athlon64 -O2 -pipe -Wall -W -D_REENTRANT  -DQT_KEYWORDS -DQT_NO_DEBUG -DQT_XML_
LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE -DQT_SHARED -I
../../mkspecs/linux-g++-64 -I. -I../../include/QtCore -I../../include/QtNetwork -I../../include/QtGui -I
../../include/QtXml -I../../include -I.moc/release-shared -I. -o .obj/release-shared/index.o index.cpp
docuparser.cpp: In member function `virtual bool DocuParser310::startElement(const QString&, const QStri
ng&, const QString&, const QXmlAttributes&)':
docuparser.cpp:166: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugs.gentoo.org/> for instructions.
g++ -c -m64 -pipe -march=athlon64 -O2 -pipe -Wall -W -D_REENTRANT  -DQT_KEYWORDS -DQT_NO_DEBUG -DQT_XML_
LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE -DQT_SHARED -I
../../mkspecs/linux-g++-64 -I. -I../../include/QtCore -I../../include/QtNetwork -I../../include/QtGui -I
../../include/QtXml -I../../include -I.moc/release-shared -I. -o .obj/release-shared/profile.o profile.c
pp
The bug is not reproducible, so it is likely a hardware or OS problem.
make[2]: *** [.obj/release-shared/docuparser.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/var/tmp/portage/qt-4.1.1/work/qt-x11-opensource-src-4.1.1/tools/assistant'
make[1]: *** [sub-assistant-all-ordered] Error 2
make[1]: Leaving directory `/var/tmp/portage/qt-4.1.1/work/qt-x11-opensource-src-4.1.1/tools'
make: *** [sub-tools-all-ordered] Error 2

...

real    49m35.866s
user    29m19.670s
sys     16m7.792s


I'm going to build/test 2.6.16-rc1.

-- 
	Paolo Ornati
	Linux 2.6.16 on x86_64

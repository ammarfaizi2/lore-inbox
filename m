Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUFULcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUFULcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUFULcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:32:13 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:49629 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S266194AbUFULcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:32:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [PATCH] Handle non-readable binfmt misc executables
Date: Mon, 21 Jun 2004 14:31:57 +0300
Message-ID: <2C83850C013A2540861D03054B478C060416C175@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Handle non-readable binfmt misc executables
thread-index: AcRW1GwAYgdqaT22QXuBtEos7axMwAAlgo7w
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Albert Cahalan" <albert@users.sourceforge.net>
Cc: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jun 2004 11:31:58.0267 (UTC) FILETIME=[5CCFC8B0:01C45783]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Albert Cahalan [mailto:albert@users.sourceforge.net] 
>Sent: Sunday, June 20, 2004 15:17
>To: Zach, Yoav
>Cc: linux-kernel mailing list
>Subject: RE: [PATCH] Handle non-readable binfmt misc executables
>


>So the content of /proc/*/cmdline is correct?
>

After the translator fixes it - yes.

>At a minimum, you will have a problem at startup.
>The process might be observed before you fix argv.
>

Right. It might happen once in a (long) while that
'ps -f' doesn't show the correct command line. 

>What about apps that walk off the end of argv to get
>at the environment?
>

Please note that the stack is that of the translator, which
is aware of the fixing of argv.

>It seems cleaner to use some other mechanism.
>Assuming your interpreter is ELF, ELF notes are good.

Using ELF notes means changing the binaries, which is not
suitable for cases where the use of translator for running
the binaries is not 'known' to the binaries. For example,
an administrator might start using a translator to enhance
performance of existing binaries. In such a case, re-building
the binaries will probably be out of the question.

>You might use prctl().
>

Do you mean enhancing sys_prctl to allow for fixing 
the argv ? 

Thanks,
Yoav.

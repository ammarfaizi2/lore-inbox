Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVBSQT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVBSQT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVBSQT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:19:27 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:5696 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261299AbVBSQTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:19:24 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Vicente Feito <vicente.feito@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
X-Message-Flag: Warning: May contain useful information
References: <200502190148.11334.vicente.feito@gmail.com>
	<52is4ptae0.fsf@topspin.com> <42174DD4.9010506@keyaccess.nl>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 19 Feb 2005 08:19:23 -0800
In-Reply-To: <42174DD4.9010506@keyaccess.nl> (Rene Herman's message of "Sat,
 19 Feb 2005 15:31:48 +0100")
Message-ID: <52acq0ttdg.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Feb 2005 16:19:23.0730 (UTC) FILETIME=[C649DB20:01C5169E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Rene> I have no idea about the module refcounting stuff. Is there
    Rene> a chance that create_workqueue() could increase a reference
    Rene> somewhere so that the module wouldn't be allowed to unload
    Rene> untill after a destroy_workqueue()?

There's no point to doing this, since it's adding complexity to try
and avoid a very obvious and easy to find bug.  Other types of
resource leaks are harder to find, but a module not destroying a
workqueue is going to be trivial to spot and fix.

(There are technical issues as well -- if create_workqueue()
increments the module reference count, then you would never be able to
unload the module if the destroy_workqueue() was in the module_exit
function, because you can never even start to unload a module with a
non-zero ref count).

 - R.

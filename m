Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVBSEqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVBSEqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 23:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBSEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 23:46:43 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:1785 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261624AbVBSEqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 23:46:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:organization:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K2DGsGtFZYJYRIoeKljcxVJ7yurSLNuKY4HQ4Aj5Lg079ZxafT5ttACd/mlsetaFJ/sHi7nclwQcPAIpeaakH3wdIqD5i2p8/wbYaewMnyRybSYqPOITi3/v1eF/sYayhIEWrAhDOu4kfjWwYr2AJlmCyIwgYiVy+IZtwwCpiZQ=
From: Vicente Feito <vicente.feito@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: workqueue - process context
Date: Sat, 19 Feb 2005 01:48:11 +0000
User-Agent: KMail/1.7.1
Organization: none
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502190148.11334.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with workqueues, and I've found that once I unload the 
module, if I don't call destroy_workqueue(); then the workqueue I've created 
stays in the process list, [my_wq], I don't know if that's meant to be, or is 
it a bug, cause I believe there can be two options in here:

1) It's meant to be so you can unload your module and let the works run some 
time after you're already gone, that allows you to probe other modules or do 
whatever necesary without the need to wait for the workqueue to be emtpy.

2) It's a bug, cause the module allows to be unloaded, destroying the structs 
but not removing the workqueue from the process context.

Which one is it?I hope I'm being clear with my question.
I was about to try to find a solution to remove the queue but maybe it's meant 
to be, although not likely.

Vicente.

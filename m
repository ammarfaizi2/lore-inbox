Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTLHXzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTLHXzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:55:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:3213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbTLHXy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:54:58 -0500
Message-Id: <200312082354.hB8NsqZ17359@mail.osdl.org>
Date: Mon, 8 Dec 2003 15:54:49 -0800 (PST)
From: markw@osdl.org
Subject: hyperthreading performance with dbt-2 on 2.6.0-test11
To: linux-kernel@vger.kernel.org
cc: osdldbt-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have some data with hyperthreading I wanted to share.

I've seen about a 15% performance decrease in performance on a 4-way
Xeon system when I enable hyperthreading for my DBT-2 workload.  I also
gave Ingo's test11-C1 patch that someone pointed me to a try and only
saw a 12% decrease. Has anyone found this to be common with any specific
workloads?

I'm not really sure what to look for, but I do see some changes in the
readprofile data, which I've copied in part below.  It appears that the
count of schedule, __make_request, and try_to_wake_up are the only
functions at the top of the profile that are significantly different.
The links I have posted also have pointers to oprofile data as well as
annotated assembly source output, if that interests anyone.  If I can
provide any other details, let me know.

For the test with no hyperthreading
(http://developer.osdl.org/markw/dbt2-pgsql/258/):

8199701 poll_idle                                141374.1552
159442 schedule                                  93.5144
133488 __copy_from_user_ll                      1059.4286
128589 __copy_to_user_ll                        1071.5750
 73209 DAC960_LP_InterruptHandler               367.8844
 51885 __make_request                            36.0062
 35614 try_to_wake_up                            55.6469


For the test with hyperthreading
(http://developer.osdl.org/markw/dbt2-pgsql/253/):

20893773 poll_idle                                360237.4655
351988 schedule                                 206.4446
155826 __copy_from_user_ll                      1038.8400
152346 __copy_to_user_ll                        1269.5500
 90983 DAC960_LP_InterruptHandler               457.2010
 86936 try_to_wake_up                           135.8375
 70122 __make_request                            48.6620


For the test with hyperthreading and Ingo's patch
(http://developer.osdl.org/markw/dbt2-pgsql/260/):

20544823 poll_idle                                354221.0862
520575 schedule                                 231.6756
159609 __copy_from_user_ll                      1266.7381
153279 __copy_to_user_ll                        1277.3250
139321 try_to_wake_up                           221.4960
 92447 DAC960_LP_InterruptHandler               464.5578
 72162 __make_request                            50.0777


-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/

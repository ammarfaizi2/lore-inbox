Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbTCXIxE>; Mon, 24 Mar 2003 03:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbTCXIxE>; Mon, 24 Mar 2003 03:53:04 -0500
Received: from holomorphy.com ([66.224.33.161]:12700 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262120AbTCXIxD>;
	Mon, 24 Mar 2003 03:53:03 -0500
Date: Mon, 24 Mar 2003 01:03:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, rwhron@earthlink.net
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <20030324090321.GJ1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, rwhron@earthlink.net
References: <3E7C8B22.7020505@nortelnetworks.com> <3E7EA0F6.8000308@nortelnetworks.com> <b5mg86$qm$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5mg86$qm$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen  <cfriesen@nortelnetworks.com> wrote:
>> The ones that stand out are:
>> --fork/exec (due to rmap I assume?)
>> --mmap (also due to rmap?)

On Mon, Mar 24, 2003 at 08:39:34AM +0000, Linus Torvalds wrote:
> Yes. You could try the objrmap patches, they are supposed to help. They
> may be in -mm, I'm not sure.

I recently asked Randy Hron which 2.5.x patches made the biggest
difference in the tests he's done. He pasted the following:

<hrandoz:#kernelnewbies>                                  null     null       
+               open    signal   signal    fork    execve  /bin/sh
<hrandoz:#kernelnewbies> kernel                           call      I/O    
+stat    fstat    close   install   handle  process  process  process
<hrandoz:#kernelnewbies> 2.5.65                            0.66  0.96298     3
+.60     1.48     5.31     1.92     3.89     1279     3233    13703
<hrandoz:#kernelnewbies> 2.5.65-mm1                        0.63  1.04114     3
+.65     1.57     6.39     2.29     3.92     1370     3621    13985
<hrandoz:#kernelnewbies> 2.5.65-mm2                        0.65  0.98654     3
+.64     1.46     6.88     1.91     3.94     1511     3676    13502
<hrandoz:#kernelnewbies> 2.5.65-mm2-anobjrmap              0.66  0.96061     3
+.82     1.45     5.38     1.90     4.68     1414     3497    13169
<hrandoz:#kernelnewbies> 2.2.23                            0.42  0.80455     4
+.76     1.24     5.77     1.43     2.74      788     2303    30829
<hrandoz:#kernelnewbies> 2.4.21-pre4aa3                    0.62  0.72201     3
+.44     1.02     5.32     1.41     3.43      848     2114    10117
<hrandoz:#kernelnewbies> 2.4.21-pre5                       0.62  0.75284     3
+.18     1.02     5.35     1.41     3.25      927     2559    11884
<hrandoz:#kernelnewbies> 2.4.21-pre5-akpm                  0.61  0.73119     3
+.32     1.02     5.28     1.41     3.16      865     2421    11636
<hrandoz:#kernelnewbies> 2.5.63-mjb1                       0.66  1.12795     4
+.01     1.64     6.66     1.92     4.49     1125     2793    12475
<hrandoz:#kernelnewbies> 2.5.62-mjb2                       0.64  1.09703     4
+.12     1.66     5.77     1.89     4.05     1128     2888    12669
<hrandoz:#kernelnewbies> 2.5.63-mjb2                       0.67  1.03824     4
+.12     1.66     5.87     1.90     4.39     1144     2985    12650
<hrandoz:#kernelnewbies> 2.5.62-mm3                        0.62  0.95155     4
+.72     1.42     7.55     1.90     3.92     1164     3073    13101


-- wli

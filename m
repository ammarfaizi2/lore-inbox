Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUFIPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUFIPpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUFIPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:45:12 -0400
Received: from pecan.cc.columbia.edu ([128.59.59.178]:43502 "EHLO
	pecan.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S265200AbUFIPoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:44:46 -0400
Message-ID: <40C7306A.2090503@cs.columbia.edu>
Date: Wed, 09 Jun 2004 11:44:42 -0400
From: Haoqiang Zheng <hzheng@cs.columbia.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: ckrm-tech <ckrm-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: restarting CKRM CPU scheduler development
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-No-Spam-Score: Local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that CKRM's interfaces and core seem to have reached a fairly stable 
state, its worthwhile to restart the CPU scheduler implementation for 
CKRM. Summarized below are some of the discussions with Hubertus and 
Shailabh on the next steps.

Over the next couple of months, we would like to tackle the design and 
implementation of the CPU scheduler, using ideas/code from the first 
implementation, the new requirements of the CKRM project and all the new 
developments on the  2.6 CPU scheduling front. Thats a tall order  ! So 
please help with comments and code.

For the most part, we'll keep the discussions on ckrm-tech with cc:s to 
lkml as relevant. Please excuse the double posts in advance.

1. Integration with the latest CKRM Core patch
   The latest patch for CKRM CPU scheduler we have on the web 
(http://ckrm.sourceforge.net/phase1/index.html) is based on Linux 
2.6.0-test2 and ckcore-A01-2.6.0-test2. We have done a lot of tuning and 
clean ups since we posted this patch, but the overall design stays the 
same as what we described in the various papers posted on our project 
home page. This patch is already by far out of date since the ckcore has 
evolved to version E13 since last summer.

   We have started to integrate our current scheduler implementation 
with the ckcore-E13. Hopefully, an up to date patch for the CKRM CPU 
scheduler will be released soon.

2. Measurement
  
     We plan to do extensive evaluation of the scheduler after we finish 
the integration so that we know where we actually are, where to improve 
etc. We plan to do the following measurements. If you have good ideas of 
how the scheduler should be evaluated, please let us know.

2.1 Accuracy Measurement
  We will provide the accuracy measurement results based on the micro 
benchmarkswe used in http://ckrm.sourceforge.net/cfs/index.html.

2.2 System Responsiveness
  We will evaluate the system responsiveness of our scheduler using 
``contest'' (http://members.optusnet.com.au/ckolivas/contest/).

2.3 Scheduling Overhead
  We will provide the overhead results based on LMBench. 

Handling interactivity well is going to be a major design constraint.  
Does anyone know of other ways one can measure interactivity (other than 
having lots of developers say it "feels very responsive" ?)

3. Supporting class hierarchy and hard share limit
   The current CKRM CPU scheduler implementation doesn't support class 
hierarchy and hard share limit. We are considering two options for class 
hierarchy and share limit implementation:
   a. directly support the hierarchy and limit in the kernel CPU scheduler
   b. keep a single hierarchy of classes in the kernel while using a 
user space process or a kernel thread to adjust the relative shares of 
the classes based on the hierarchy and limit requirement

 We are leaning towards the second option since:
   a. Supporting hierarchy in the kernel scheduler will inevitably add a 
lot of scheduling overhead
   b. Considering we don't need a very fine grained accuracy control, 
the overhead added by a. is unnecessary
   c. Taking option b., the hierarchy control and the CPU scheduler can 
be developed separately, and the main scheduler code can be kept simple.

   We will provide the detailed design later. Your opinion is welcomed.

4. Other Ideas
   We are also considering incorporating some cool ideas mentioned in 
some other projects like EBS, scheduling domain etc. We are specially 
interested at EBS scheduler's way of tracking the progress of the tasks. 
We will provide our evaluations of these algorithms as we look at them 
in detail.

5. Load Balancing
    There are a lot of heuristics that we can play with for the load 
balancing. But achieving perfect load balancing will be hard. Well, 
since Linux 2.6's load balancer is also far from satisfactory anyway, We 
put the load balancer stuff at a lower priority. We will work on this 
after the other objectives are well addressed.

Best regards,
Haoqiang Zheng

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWI2Ti5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWI2Ti5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWI2Ti5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:38:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:16585 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751374AbWI2Ti4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:38:56 -0400
Subject: Re: [Lse-tech] [RFC][PATCH 02/10] Task watchers v2 Benchmark
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       sgrubb@redhat.com, hch@lst.de
In-Reply-To: <20060928193243.c6766a2a.pj@sgi.com>
References: <20060929020232.756637000@us.ibm.com>
	 <20060929021300.034805000@us.ibm.com>  <20060928193243.c6766a2a.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 29 Sep 2006 12:38:52 -0700
Message-Id: <1159558733.3286.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 19:32 -0700, Paul Jackson wrote:
> Matt wrote:
> > It is intended to be a tool for measuring the impact of task watchers
> > on fork and exit-heavy workloads.
> 
> So ... you're keeping us in suspense ... what was the measured impact
> of task watcher?

Heh, sorry about that. I do have some initial kernbench numbers. I
performed 10 successive runs of kernbench after each patch on an old
8-way:

[PATCH 01/10] Task watchers v2 Task watchers v2
815.80user 113.69system 2:04.36elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
814.55user 114.25system 2:03.80elapsed 750%CPU (0avgtext+0avgdata 0maxresident)k
815.09user 115.11system 2:04.42elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
815.84user 114.08system 2:04.25elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
814.60user 114.28system 2:04.41elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
814.52user 113.09system 2:04.51elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
816.23user 114.42system 2:04.64elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
816.45user 113.39system 2:04.72elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
815.62user 114.74system 2:04.71elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
814.40user 112.94system 2:04.45elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 02/10] Task watchers v2 Benchmark
806.39user 113.23system 2:04.30elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k
806.21user 112.87system 2:03.40elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
811.69user 113.59system 2:03.59elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
803.16user 113.37system 2:03.53elapsed 741%CPU (0avgtext+0avgdata 0maxresident)k
804.82user 112.25system 2:03.62elapsed 741%CPU (0avgtext+0avgdata 0maxresident)k
804.45user 113.37system 2:03.34elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
806.35user 112.34system 2:02.96elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
804.35user 112.61system 2:02.96elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
804.19user 112.98system 2:02.91elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
804.54user 113.23system 2:03.80elapsed 741%CPU (0avgtext+0avgdata 0maxresident)k

Seems like this benchmark patch resulted in a consistent decrease in time
spent in userspace. I'm rerunning kernbench without this patch and will post the
results by Monday afternoon at the latest.

[PATCH 03/10] Task watchers v2 Register audit task watcher
802.30user 113.37system 2:02.36elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
802.19user 111.93system 2:03.68elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k
800.90user 113.33system 2:03.02elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
800.08user 112.56system 2:01.95elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
801.53user 111.66system 2:02.87elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
803.62user 112.22system 2:02.34elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
803.65user 112.05system 2:03.07elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
804.35user 112.35system 2:03.85elapsed 740%CPU (0avgtext+0avgdata 0maxresident)k
805.20user 112.25system 2:02.80elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
802.46user 113.74system 2:03.75elapsed 740%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 04/10] Task watchers v2 Register semundo task watcher
799.99user 113.19system 2:02.50elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
802.11user 112.51system 2:03.62elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k
802.19user 112.40system 2:04.19elapsed 736%CPU (0avgtext+0avgdata 0maxresident)k
803.87user 113.05system 2:02.96elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
802.56user 113.38system 2:02.52elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
803.14user 113.11system 2:02.95elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
802.57user 113.66system 2:02.56elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
803.26user 113.90system 2:03.37elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
806.66user 113.95system 2:03.20elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
805.21user 113.31system 2:04.20elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 05/10] Task watchers v2 Register cpuset task watcher
807.24user 112.35system 2:03.11elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
804.43user 112.62system 2:03.08elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
805.80user 113.85system 2:04.10elapsed 741%CPU (0avgtext+0avgdata 0maxresident)k
806.28user 114.07system 2:03.47elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
807.08user 114.10system 2:04.14elapsed 742%CPU (0avgtext+0avgdata 0maxresident)k
807.39user 113.68system 2:03.57elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
807.60user 113.27system 2:03.69elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
807.06user 113.25system 2:03.89elapsed 742%CPU (0avgtext+0avgdata 0maxresident)k
808.79user 112.62system 2:03.31elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
805.21user 113.96system 2:03.75elapsed 742%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 06/10] Task watchers v2 Register NUMA mempolicy task watcher
804.88user 113.50system 2:03.04elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
807.87user 114.55system 2:04.05elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
812.19user 113.81system 2:04.21elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
810.73user 114.06system 2:04.26elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
808.18user 113.48system 2:03.06elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
810.50user 112.26system 2:04.32elapsed 742%CPU (0avgtext+0avgdata 0maxresident)k
808.79user 113.65system 2:04.58elapsed 740%CPU (0avgtext+0avgdata 0maxresident)k
807.73user 113.55system 2:03.85elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
806.90user 113.25system 2:03.83elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k
804.28user 113.75system 2:03.45elapsed 743%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 07/10] Task watchers v2 Register IRQ flag tracing task watcher
795.59user 111.36system 2:02.19elapsed 742%CPU (0avgtext+0avgdata 0maxresident)k
795.09user 112.89system 2:02.74elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k
796.29user 112.05system 2:01.58elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
796.95user 112.99system 2:03.24elapsed 738%CPU (0avgtext+0avgdata 0maxresident)k
798.78user 111.45system 2:01.75elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
796.52user 112.00system 2:01.73elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
797.40user 112.65system 2:02.02elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
797.02user 112.55system 2:01.50elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
799.72user 111.69system 2:02.36elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
799.39user 111.93system 2:02.24elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 08/10] Task watchers v2 Register lockdep task watcher
804.79user 111.78system 2:03.03elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
805.81user 110.94system 2:03.13elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
803.87user 112.09system 2:02.96elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
805.32user 113.28system 2:03.35elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
803.45user 112.53system 2:02.89elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
803.69user 112.29system 2:02.90elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
801.01user 112.27system 2:02.15elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
802.30user 112.59system 2:02.87elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
802.19user 111.69system 2:02.66elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
801.97user 111.75system 2:02.66elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 09/10] Task watchers v2 Register process keyrings task watcher
792.91user 111.19system 2:00.91elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
793.50user 110.64system 2:02.37elapsed 738%CPU (0avgtext+0avgdata 0maxresident)k
795.85user 111.00system 2:01.39elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
794.46user 112.29system 2:01.17elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
794.04user 111.91system 2:01.44elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
797.07user 110.94system 2:01.55elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
796.84user 110.37system 2:01.41elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
796.13user 110.69system 2:02.44elapsed 740%CPU (0avgtext+0avgdata 0maxresident)k
805.46user 110.87system 2:02.66elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
796.70user 111.36system 2:02.80elapsed 739%CPU (0avgtext+0avgdata 0maxresident)k

[PATCH 10/10] Task watchers v2 Register process events connector
807.06user 112.29system 2:04.01elapsed 741%CPU (0avgtext+0avgdata 0maxresident)k
807.76user 113.42system 2:03.14elapsed 748%CPU (0avgtext+0avgdata 0maxresident)k
806.95user 111.51system 2:03.33elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
805.65user 112.95system 2:04.04elapsed 740%CPU (0avgtext+0avgdata 0maxresident)k
803.63user 113.79system 2:03.01elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k
807.15user 111.49system 2:03.32elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
807.75user 112.02system 2:03.47elapsed 744%CPU (0avgtext+0avgdata 0maxresident)k
804.89user 113.48system 2:03.02elapsed 746%CPU (0avgtext+0avgdata 0maxresident)k
806.01user 112.71system 2:02.84elapsed 747%CPU (0avgtext+0avgdata 0maxresident)k
804.40user 112.63system 2:02.94elapsed 745%CPU (0avgtext+0avgdata 0maxresident)k

Cheers,
	-Matt Helsley


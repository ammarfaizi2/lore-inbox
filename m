Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVC0Kxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVC0Kxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 05:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVC0Kxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 05:53:55 -0500
Received: from mail.dif.dk ([193.138.115.101]:33511 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261515AbVC0Kxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 05:53:38 -0500
Date: Sun, 27 Mar 2005 12:55:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-os <linux-os@analogic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <1111881955.957.11.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
  <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com> 
 <1111825958.6293.28.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com> 
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Lee Revell wrote:

> On Sun, 2005-03-27 at 00:54 +0100, Jesper Juhl wrote:
> > I'd say that the general rule should
> > be "don't check for NULL first unless you *know* the pointer will be NULL
> > >50% of the time"... 
> 
> How about running the same tests but using likely()/unlikely() for the
> '1 in 50' cases?
> 
I added likely() and unlikely() to all tests, here are the results from 3 
runs on my box : 


[ 4379.223858] starting test : 50/50 NULL pointers, kfree(p)
[ 4379.785541] Test done. This test used up 240 kfree related jiffies
[ 4379.785543] -------------------------
[ 4379.884863] starting test : 50/50 NULL pointers, if(p) kfree(p)
[ 4380.609537] Test done. This test used up 221 kfree related jiffies
[ 4380.609539] -------------------------
[ 4380.709285] starting test : 50/50 NULL pointers, if(likely(p)) kfree(p)
[ 4381.241958] Test done. This test used up 237 kfree related jiffies
[ 4381.241961] -------------------------
[ 4381.341843] starting test : 50/50 NULL pointers, if(unlikely(p)) kfree(p)
[ 4381.874492] Test done. This test used up 261 kfree related jiffies
[ 4381.874495] -------------------------
[ 4381.974396] starting test : 49 out of 50 pointers == NULL, kfree(p)
[ 4382.239784] Test done. This test used up 87 kfree related jiffies
[ 4382.239787] -------------------------
[ 4382.339138] starting test : 49 out of 50 pointers == NULL, if(p) kfree(p)
[ 4382.519165] Test done. This test used up 22 kfree related jiffies
[ 4382.519167] -------------------------
[ 4382.618944] starting test : 49 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4382.798832] Test done. This test used up 18 kfree related jiffies
[ 4382.798834] -------------------------
[ 4382.898746] starting test : 49 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4383.079062] Test done. This test used up 26 kfree related jiffies
[ 4383.079065] -------------------------
[ 4383.178549] starting test : 1 out of 50 pointers == NULL, kfree(p)
[ 4384.187707] Test done. This test used up 365 kfree related jiffies
[ 4384.187710] -------------------------
[ 4384.286769] starting test : 1 out of 50 pointers == NULL, if(p) kfree(p)
[ 4385.351731] Test done. This test used up 438 kfree related jiffies
[ 4385.351733] -------------------------
[ 4385.450951] starting test : 1 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4386.480408] Test done. This test used up 378 kfree related jiffies
[ 4386.480410] -------------------------
[ 4386.580161] starting test : 1 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4387.630779] Test done. This test used up 432 kfree related jiffies
[ 4387.630782] -------------------------


[ 4614.027356] starting test : 50/50 NULL pointers, kfree(p)
[ 4614.589174] Test done. This test used up 258 kfree related jiffies
[ 4614.589177] -------------------------
[ 4614.688741] starting test : 50/50 NULL pointers, if(p) kfree(p)
[ 4615.409793] Test done. This test used up 252 kfree related jiffies
[ 4615.409795] -------------------------
[ 4615.509165] starting test : 50/50 NULL pointers, if(likely(p)) kfree(p)
[ 4616.041816] Test done. This test used up 200 kfree related jiffies
[ 4616.041818] -------------------------
[ 4616.141720] starting test : 50/50 NULL pointers, if(unlikely(p)) kfree(p)
[ 4616.678002] Test done. This test used up 223 kfree related jiffies
[ 4616.678005] -------------------------
[ 4616.777275] starting test : 49 out of 50 pointers == NULL, kfree(p)
[ 4617.042512] Test done. This test used up 91 kfree related jiffies
[ 4617.042514] -------------------------
[ 4617.142017] starting test : 49 out of 50 pointers == NULL, if(p) kfree(p)
[ 4617.322044] Test done. This test used up 24 kfree related jiffies
[ 4617.322047] -------------------------
[ 4617.421820] starting test : 49 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4617.601710] Test done. This test used up 29 kfree related jiffies
[ 4617.601713] -------------------------
[ 4617.701625] starting test : 49 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4617.882083] Test done. This test used up 27 kfree related jiffies
[ 4617.882085] -------------------------
[ 4617.981427] starting test : 1 out of 50 pointers == NULL, kfree(p)
[ 4618.990599] Test done. This test used up 355 kfree related jiffies
[ 4618.990601] -------------------------
[ 4619.089646] starting test : 1 out of 50 pointers == NULL, if(p) kfree(p)
[ 4620.154737] Test done. This test used up 388 kfree related jiffies
[ 4620.154740] -------------------------
[ 4620.253829] starting test : 1 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4621.283279] Test done. This test used up 372 kfree related jiffies
[ 4621.283282] -------------------------
[ 4621.383035] starting test : 1 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4622.442580] Test done. This test used up 468 kfree related jiffies
[ 4622.442583] -------------------------


[ 4673.948568] starting test : 50/50 NULL pointers, kfree(p)
[ 4674.513874] Test done. This test used up 257 kfree related jiffies
[ 4674.513877] -------------------------
[ 4674.613603] starting test : 50/50 NULL pointers, if(p) kfree(p)
[ 4675.338429] Test done. This test used up 256 kfree related jiffies
[ 4675.338432] -------------------------
[ 4675.438022] starting test : 50/50 NULL pointers, if(likely(p)) kfree(p)
[ 4675.970685] Test done. This test used up 209 kfree related jiffies
[ 4675.970687] -------------------------
[ 4676.070575] starting test : 50/50 NULL pointers, if(unlikely(p)) kfree(p)
[ 4676.603217] Test done. This test used up 233 kfree related jiffies
[ 4676.603219] -------------------------
[ 4676.703132] starting test : 49 out of 50 pointers == NULL, kfree(p)
[ 4676.968502] Test done. This test used up 82 kfree related jiffies
[ 4676.968504] -------------------------
[ 4677.067877] starting test : 49 out of 50 pointers == NULL, if(p) kfree(p)
[ 4677.247945] Test done. This test used up 17 kfree related jiffies
[ 4677.247948] -------------------------
[ 4677.347675] starting test : 49 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4677.527564] Test done. This test used up 29 kfree related jiffies
[ 4677.527566] -------------------------
[ 4677.627480] starting test : 49 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4677.807935] Test done. This test used up 19 kfree related jiffies
[ 4677.807937] -------------------------
[ 4677.907282] starting test : 1 out of 50 pointers == NULL, kfree(p)
[ 4678.916434] Test done. This test used up 404 kfree related jiffies
[ 4678.916437] -------------------------
[ 4679.015503] starting test : 1 out of 50 pointers == NULL, if(p) kfree(p)
[ 4680.087547] Test done. This test used up 423 kfree related jiffies
[ 4680.087549] -------------------------
[ 4680.186681] starting test : 1 out of 50 pointers == NULL, if(likely(p)) kfree(p)
[ 4681.209136] Test done. This test used up 373 kfree related jiffies
[ 4681.209139] -------------------------
[ 4681.308891] starting test : 1 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)
[ 4682.366623] Test done. This test used up 449 kfree related jiffies
[ 4682.366625] -------------------------


And here's the source for the module that generated the above : 


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/compiler.h>
#include <linux/workqueue.h>

#define NR_TESTS	10000000

void do_kfreetest_work(void *data);

DECLARE_WORK(kfree_work, do_kfreetest_work, NULL);

static int test_time[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

void do_kfreetest_work(void *data)
{
	unsigned long j;
	static int what_test = 0;
	unsigned long start;
	void *tmp;

	printk(KERN_ALERT "starting test : ");
	switch (what_test) {
		case 0:
			printk("50/50 NULL pointers, kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 1:
			printk("50/50 NULL pointers, if(p) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 2:
			printk("50/50 NULL pointers, if(likely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (likely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 3:
			printk("50/50 NULL pointers, if(unlikely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (unlikely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 4:
			printk("49 out of 50 pointers == NULL, kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 5:
			printk("49 out of 50 pointers == NULL, if(p) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 6:
			printk("49 out of 50 pointers == NULL, if(likely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (likely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 7:
			printk("49 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (unlikely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 8:
			printk("1 out of 50 pointers == NULL, kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 9:
			printk("1 out of 50 pointers == NULL, if(p) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 10:
			printk("1 out of 50 pointers == NULL, if(likely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				if (likely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		case 11:
			printk("1 out of 50 pointers == NULL, if(unlikely(p)) kfree(p)\n");
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				if (unlikely(tmp))
					kfree(tmp);
				test_time[what_test] += jiffies - start;
			}
			break;
		default:
			printk(KERN_ALERT "hit default\n");
			break;
	}
	printk(KERN_ALERT "Test done. This test used up %d kfree related jiffies\n-------------------------\n", test_time[what_test]);
	
	if (what_test < 11)
		schedule_delayed_work(&kfree_work, 100);
	else
		printk(KERN_ALERT "All tests done.....\n-----------------------------------\n");

	what_test++;
}

static int kfreetest_init(void)
{
	schedule_work(&kfree_work);
	return 0;
}

static void kfreetest_exit(void)
{
	cancel_delayed_work(&kfree_work);
	flush_scheduled_work();
}

module_init(kfreetest_init);
module_exit(kfreetest_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jesper Juhl");




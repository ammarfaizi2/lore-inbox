Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVCBJ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVCBJ1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVCBJ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:27:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:12746 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262240AbVCBJZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:25:54 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, hadi@cyberus.ca, tgraf@suug.ch,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Netlink List <netdev@oss.sgi.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050302010614.2a8bb483.akpm@osdl.org>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
	 <1109604693.1072.8.camel@jzny.localdomain>
	 <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	 <1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	 <42247051.7070303@ak.jp.nec.com>
	 <1109753893.8422.127.camel@frecb000711.frec.bull.fr>
	 <20050302010614.2a8bb483.akpm@osdl.org>
Date: Wed, 02 Mar 2005 10:25:49 +0100
Message-Id: <1109755549.32740.8.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 10:34:51,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 10:34:55,
	Serialize complete at 02/03/2005 10:34:55
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 01:06 -0800, Andrew Morton wrote: 
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> >   So I ran the lmbench with three different kernels with the fork
> >  connector patch I just sent. Results are attached at the end of the mail
> >  and there are three different lines which are:
> > 
> >  	o First line is  a linux-2.6.11-rc4-mm1-cnfork
> >  	o Second line is a linux-2.6.11-rc4-mm1
> >  	o Third line is  a linux-2.6.11-rc4-mm1-cnfork with a user space
> >            application. The user space application listened during 15h 
> >            and received 6496 messages.
> > 
> >  Each test has been ran only once. 
> > 
> > ...
> >  ------------------------------------------------------------------------------
> >  Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
> >                               call  I/O stat clos TCP  inst hndl proc proc proc
> >  --------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
> >  account   Linux 2.6.11- 2765 0.17 0.26 3.57 4.19 16.9 0.51 2.31 162. 629. 2415
> >  account   Linux 2.6.11- 2765 0.16 0.26 3.56 4.17 17.6 0.50 2.30 163. 628. 2417
> >  account   Linux 2.6.11- 2765 0.16 0.27 3.67 4.25 17.6 0.51 2.28 176. 664. 2456
> 
> This is the interesting bit, yes?  5-10% slowdown on fork is expected, but
> why was exec slower?

I can't explain it for the moment. I will run test more than once to see
if this difference is still here.

> What does "The user space application listened during 15h" mean?

  It means that I ran the user space application before the test and
stop it 15 hours later (this morning for me). The test ran during
5h30mn. 

  The user space application increments a counter to show how many
processes have been created during a period of time. I have not use the
user space daemon that manages group of processes because the it still
uses the old mechanism (a signal sends from the do_fork()) and as I
wanted to provide quick results, I used another user space application.

  I attache the test program (get_fork_info.c) that I'm using at the end
of the mail to clearly show what it does. 

  I will run new tests with the real user space daemon but it will be
ready next week, sorry for the delay.

Best regards,
Guillaume

---

/*
 * get_fork_info.c
 *
 * This program listens netlink interface to retreive information
 * sends by the kernel when forking. It increments a counter for
 * each forks and when the user hit CRL-C, it displays how many
 * fork occured during the period.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <signal.h>

#include <asm/types.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>

#include <linux/netlink.h>
#include <linux/connector.h>


#define CN_FORK_OFF	0
#define CN_FORK_ON	1

#define MESSAGE_SIZE	(sizeof(struct nlmsghdr) + \
		         sizeof(struct cn_msg)   + \
		         sizeof(int))

int sock;
unsigned long total_p;
struct timeval test_time;

static inline void switch_cn_fork(int sock, int action)
{
	char buff[128];		/* must be > MESSAGE_SIZE */
	struct nlmsghdr *hdr;
	struct cn_msg *msg;

	/* Clear the buffer */
	memset(buff, '\0', sizeof(buff));

	/* fill the message header */
	hdr = (struct nlmsghdr *) buff;

	hdr->nlmsg_len = MESSAGE_SIZE;
	hdr->nlmsg_type = NLMSG_DONE;
	hdr->nlmsg_flags = 0;
	hdr->nlmsg_seq = 0;
	hdr->nlmsg_pid = getpid();

	/* the message */
	msg = (struct cn_msg *) NLMSG_DATA(hdr);
	msg->id.idx = CN_IDX_FORK;
	msg->id.val = CN_VAL_FORK;
	msg->seq = 0;
	msg->ack = 0;
	msg->len = sizeof(int);
	msg->data[0] = action;

	send(sock, hdr, hdr->nlmsg_len, 0);
}

static void cleanup()
{
	struct timeval tmp_time;

	switch_cn_fork(sock, CN_FORK_OFF);

	tmp_time = test_time;
	gettimeofday(&test_time, NULL);
	
	printf("%lu processes were created in %li seconds.\n", 
	 	total_p, test_time.tv_sec - tmp_time.tv_sec);

	close(sock);

	exit(EXIT_SUCCESS);
}

int main()
{
	int err;
	struct sockaddr_nl sa;	/* information for NETLINK interface */

	/*
	 * To be able to quit the application properly we install a 
	 * signal handler that catch the CTRL-C
	 */
	signal(SIGTERM, cleanup);
	signal(SIGINT, cleanup);

	/* 
	 * Create an endpoint for communication. Use the kernel user
	 * interface device (PF_NETLINK) which is a datagram oriented
	 * service (SOCK_DGRAM). The protocol used is the netfilter/iptables 
	 * ULOG protocol (NETLINK_NFLOG)
	 */
	sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (sock == -1) {
		perror("socket");
		return -1;
	}

	sa.nl_family = AF_NETLINK;
	sa.nl_groups = CN_IDX_FORK;
	sa.nl_pid = getpid();

	err = bind(sock, (struct sockaddr *) &sa,
		   sizeof(struct sockaddr_nl));
	if (err == -1) {
		perror("bind");
		close(sock);
		return -1;
	}

	switch_cn_fork(sock, CN_FORK_ON);

	total_p = 0;

	gettimeofday(&test_time, NULL);

	for (;;) {
		char buff[1024];	/* it's large enough */
		struct nlmsghdr *hdr;
		struct cn_msg *msg;
		int len;

		/* Clear the buffer */
		memset(buff, '\0', sizeof(buff));

		/* Listen */
		len = recv(sock, buff, sizeof(buff), 0);
		if (len == -1) {
			perror("recv");
			close(sock);
			return -1;
		}

		/* point to the message header */
		hdr = (struct nlmsghdr *) buff;

		switch (hdr->nlmsg_type) {
		case NLMSG_DONE:
			msg = (struct cn_msg *) NLMSG_DATA(hdr);
			total_p++;
#if 0
			printf("[idx=0x%x seq=%u] %s\n", msg->id.idx,
			       msg->seq, msg->data);
#endif
			break;
		case NLMSG_ERROR:
			printf("NLMSG_ERROR\n");
			/* Fall through */
		default:
			break;

		}
	}

	/* 
	 * in fact we never reach this part of the code because there is an 
	 * infinite loop above.
	 */
	cleanup();
	return 0;
}



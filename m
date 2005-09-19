Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVISRkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVISRkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVISRkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:40:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:914 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932519AbVISRkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:40:18 -0400
Subject: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wq1WkOhuRoNaht9L5quD"
Date: Mon, 19 Sep 2005 10:39:33 -0700
Message-Id: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wq1WkOhuRoNaht9L5quD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I am looking at a problem where the parent process doesn't seem 
to cleanup the exited children (with a webserver). We narrowed it
down to a simple testcase. Seems more like a lost SIG_CHILD.

I can easily reproduce the problem on my AMD64 machine. 
Any thoughts on why this is happening ? Any known issues/fixes ?

Thanks,
Badari

elm3b29:~ # ./proctest 10 30
Parent process id: 30007
Spawned 10 children
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Waiting for 10 children to exit
Child 0 exiting. Executed 3682 forks
Child 3 exiting. Executed 3677 forks
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
Waiting for 8 children to exit
...

#ps -aef 
....
root     30007 20480  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30009 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30011 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30015 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30017 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30019 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30023 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30026 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root     30031 30007  0 02:35 pts/1    00:00:00 ./proctest 10 30
root       698 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       704 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       724 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       730 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       738 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       754 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       761 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       766 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       781 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       786 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       792 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       814 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       820 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       833 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       840 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       859 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       868 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       876 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       890 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       900 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       903 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       911 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       924 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       930 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       935 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root       939 30023  0 02:35 pts/1    00:00:00 [child] <defunct>
root      2822 30017  0 02:35 pts/1    00:00:00 [child] <defunct>
root      2826 30017  0 02:35 pts/1    00:00:00 [child] <defunct>
root      2834 30017  0 02:35 pts/1    00:00:00 [child] <defunct>
root      2842 30017  0 02:35 pts/1    00:00:00 [child] <defunct>
...
...

elm3b29:~ # strace -p 30023
Process 30023 attached - interrupt to quit
futex(0x2aaaaaddf118, FUTEX_WAIT, 2, NULL


--=-wq1WkOhuRoNaht9L5quD
Content-Disposition: attachment; filename=proctest.c
Content-Type: text/x-csrc; name=proctest.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/* proctest.c
 * Test the destruction of zombie processes
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/resource.h>

#define MIN_DELAY 500000
#define MAX_DELAY 2000000
#define MAX_RAND_DELAY MAX_DELAY-MIN_DELAY

static int child_count;
static int *pids;

void usage()
{
    printf("USAGE: proctest [child count] [duration in sec]\n");
}

int rand_delay()
{
    int delay = (int)(MAX_DELAY*rand()/(RAND_MAX+1.0));
    return delay;
}

int child_process(int i, int duration)
{
	time_t tt;
	struct timeval tv;
	struct timezone tz;
	int cnt=0;
	gettimeofday(&tv,&tz);
	tt=tv.tv_sec;
	while(tv.tv_sec - tt < duration ) {
		cnt++;
		if (!fork()) {
		    execve("./child",NULL,NULL);
		    _exit(0);
		}
    		usleep(rand_delay()); 
		gettimeofday(&tv,&tz);
	}

    fprintf(stderr,"Child %d exiting. Executed %d forks \n",i,cnt);
    return 0;
}

int pids_remaining()
{
    int i, count = 0;
    for (i = 0; i < child_count; i++)
    {
        if (pids[i] != 0)
            count++;
    }
    return count;
}

void pid_exited(int pid)
{
    int i;
    for (i = 0; i < child_count; i++) {
        if (pids[i] == pid) {
            pids[i] = 0;
            break;
        }
    }
}

void sigchld_handler(int signo)
{
    int status;
    struct rusage ru;
    int pid;

    /* this delay forces some children into the zombie state temporarily */
    usleep(rand_delay()); 

    while(1) {
        pid = wait4(-1, &status, WNOHANG, &ru);
        if (pid <= 0) break;
//	printf("SIGCHLD received for pid %d\n", pid);
        pid_exited(pid); 
    }
}


int main(int argc, char* argv[])
{
    int i, pid, delay, rem, duration;

    if (argc != 3) {
	usage();
	exit(1);
    }

    printf("Parent process id: %d\n", getpid());

    signal(SIGCHLD, sigchld_handler);

    srand(time(NULL));

    child_count = atoi(argv[1]);
    duration = atoi(argv[2]);

    /* storage for the children pids */
    pids = (int *)calloc(child_count, sizeof(int));

    for (i = 0; i < child_count; i++) {
        pid = fork();
        if (pid) {
            pids[i] = pid;
        } else {
            child_process(i, duration);
            _exit(0);
        }
    }
    fprintf(stderr,"Spawned %d children\n", child_count);

    while ((rem = pids_remaining()) > 0) {
        fprintf(stderr,"Waiting for %d children to exit\n", rem);
        usleep(1000000); /* 1 HZ */
    }

    fprintf(stderr,"All children have exited and been cleaned up\n");
    return 0;
}


--=-wq1WkOhuRoNaht9L5quD
Content-Disposition: attachment; filename=child.c
Content-Type: text/x-csrc; name=child.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include<stdio.h>
main()
{
// printf("PID is %d\n",getpid());
usleep(200000);
}

--=-wq1WkOhuRoNaht9L5quD--


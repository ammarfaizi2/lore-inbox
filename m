Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266282AbRGFIRE>; Fri, 6 Jul 2001 04:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbRGFIQy>; Fri, 6 Jul 2001 04:16:54 -0400
Received: from wwcst270.netaddress.usa.net ([204.68.23.15]:36757 "HELO
	wwcst270.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S266282AbRGFIQq> convert rfc822-to-8bit; Fri, 6 Jul 2001 04:16:46 -0400
Message-ID: <20010706081646.3166.qmail@wwcst270.netaddress.usa.net>
Date: 6 Jul 2001 02:16:46 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: how kernel handles sharedmemory
X-Mailer: USANET web-mailer (34FM.0700.18.03B)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
                  I am surprised how kernel handles the shared memory. When I
give issues shmget command, a sharedmemory is created and id is returned. then
I can use that sharememory by assigning to a charector array. 
                       Now in my situation, presently there is a two
dimensional array. I want to put the whole array in the shared memory. This is
because I need to share this array between the processes. So what I done is ,
I created a linklistin sharememory. But it is not working. I am giving a
sample program. Will anyone can 

#include <sys/shm.h>
typedef struct Alligned
{
	int count1;
	int count2;
	int count3;
}Alligned_pair;

char* share_alloc(int size);
Alligned_pair **m_alligned_pair;

int main()
{
	int shmid,count,childpids[1000],pid;
	Alligned_pair *s,**q;
	m_alligned_pair=(Alligned_pair**)share_alloc(1000*sizeof(Alligned_pair*));
         
	
	for(count=0;count<10;count++)
	{
		pid=fork();
		
		if (pid==0)
		{
			s=(Alligned_pair*)share_alloc(sizeof(Alligned_pair));
			s->count1=count;
			m_alligned_pair[count]=s; 	
			pid=getppid();
			waitpid(pid,0,0);
			exit(0);
		}
			

    		else
    		{
			childpids[count]=pid;
  		}
  	}
	sleep(2);
	for(count = 0; count<20; count++)
  	{
  		printf("%d    %d\n",m_alligned_pair[count],
m_alligned_pair[count]->count1);
	}
	return 1;
}	


char* share_alloc(int size)
{
	int shmid;
	char *SArray;
	shmid=shmget(random(),size,IPC_CREAT|777);
	SArray=shmat(shmid,0,0);
	return SArray;
}

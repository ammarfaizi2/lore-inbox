Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFL2W>; Wed, 6 Dec 2000 06:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLFL2M>; Wed, 6 Dec 2000 06:28:12 -0500
Received: from [202.141.79.18] ([202.141.79.18]:48139 "HELO
	hansa.krec.ernet.in") by vger.kernel.org with SMTP
	id <S129423AbQLFL15>; Wed, 6 Dec 2000 06:27:57 -0500
Date: Wed, 6 Dec 2000 15:42:24 +0530 (IST)
From: Chittari Prasanna Kumar BE <prasanna@krec.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: Checkpointing Problem!
Message-ID: <Pine.LNX.4.21.0012061538440.13812-100000@vidur.krec.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
  i am working on the project similar to Epckpt but with a concept of 
loadable module. here i have a problem in handling the page requests.

when i checkpoint a process in which malloc is used i found that if i 
malloc 1mb and make sure that all pages are used ( are present in
memory by making use of some loop in user program, i have written small
code is down ) before i checkpointed then there is no problem ,otherwise
its pmd_none is > 0 that's there is no valid pmd for it. i think i cannot
call handle_mm_fault ( or some thing like make_pages_present of mm.h,memory.c)
to bring the brk segment pages into memory because of invalid page tables!

In Epckpt he was in kernel and found it to be ok! but as i am working
as char driver i didn't get the same.

For this reason i am unable to get through it, can any one help me out.

please CC your message because i am not the list!
 
thanks for replying.

Chittari Prasanna Kumar
KREC, Surathkal.
India.


int main()
{
  int *p,i;
  p=(int *)malloc(SIZE*sizeof(int));

#if USE
 for(i=0 ; i< SIZE; i++)
   p[i]=i;
#endif
  :
  :
 
  now checkpoint here
   fails if USE is not >= 1
  
 :
 :
}




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWCRWWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWCRWWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWCRWWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:22:19 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:52704 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbWCRWWS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:22:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UIy4WgPWdf/jAs/PU8S421uBOYut7QtoQj8gI0jpOfSkkEcHqIsJ1yRsrPtZa3UKYEaPIPlCMDFlXdVSYDXXm7sLUP61qHxrSN/8DJhDfpWzJyMHnejSmrWRDuqKOQeYvmvnM2paGbN9LS6DemzV5cNgBQNHD9I44ZnzVKIRXQ8=
Message-ID: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
Date: Sun, 19 Mar 2006 03:52:17 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Idea to create a elf executable from running program [process2executable]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have been working on an idea of creating an executable from a
running process image.

MOTIVATION:
Process migration among the nodes in distributed computing,
checkpointing process state.

BASIS:

The basis of my idea would be update the existing executable with
extra PHDRS (Program Headers) with type PT_LOAD and each of these
headers corresponding the vaddr mapping from /proc/<pid>/maps.

I have done some basic study of kernels loders code in
'fs/binfmt_elf.c' especially code in 'load_elf_binary' function, the
following is my understanding.
<------------------------------------------>
bss=0;
brk=0;
foreach (phdr in elf_header){

   if(phdr->type == PT_LOAD){
        if( phdr->filesize < phdr->memsize){
           /* Segment with .bss, so update brk and bss*/
        }
       else {
          /* Just map it*/
       }
    }
/*Update brk bss*/
}
<------------------------------------>

from the above the kernel is updating brk, thus creating the start of
sbrk(0) only when it sees a  PT_LOAD segment with filesize<memsize. So
if I create a elf executable with all PT_LOAD segments with out any
segments with filesize < memsize. The kernel will set brk base i.e
sbrk(0) to the value phdr->vaddr+phdr->memsize of the last PT_LOAD
segment its mapping? so do I need to reoder my PT_LOAD segments so
that the heap goes as the last PT_LOAD segment?

Is there any way we can tell the elf loader to force the vaddr for
sbrk(0) i.e brk base ?

Let me know your suggestion on this idea?

Really appreciate your valuable comments.

Sincerely,
Vamsi

[PS: I dont know if some one has already implemented this idea??]

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbRDPWnU>; Mon, 16 Apr 2001 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDPWnK>; Mon, 16 Apr 2001 18:43:10 -0400
Received: from dsl-216-227-20-137.telocity.com ([216.227.20.137]:15635 "EHLO
	emperor") by vger.kernel.org with ESMTP id <S132387AbRDPWm6>;
	Mon, 16 Apr 2001 18:42:58 -0400
From: "Michael L. Welles" <mike@bangstate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15067.30060.436790.458922@bangstate.com>
Date: Mon, 16 Apr 2001 18:42:52 -0400 (EDT)
To: linux-kernel@vger.kernel.org
Subject: kernel space getcwd()? (using current() to find out cwd)
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably a stupid question, and probably directed to the wrong
list.  Apologies in advance, but I'm stumped

I've been working on a kernel module to report on "changed files". It
works just fine -- I wrap the orignal system calls with my
replacements which queue the filenames being modified, and when
another proccess reads from the device or proc entry, they get a nice
snapshot of what's going on in the system -- except that all the paths
are relative to the calling process.

So, a little ignorance being a dangerous thing, I thought I'd be clever
and manually reconstruct the full path by walking up
current->fs->pwd->d_parent and padding d_name to the filename until it
hits root.

Unfortunatly, this approach causes kernel panics.  e.g., the attached
code snippet will inevitably bring down the machine if I call it
during in my replacement open, mkdir, rmdir, unlink routines -- and
tehy all work fine without itq. 

What am I not getting? I do see, before I go down, that there's a few
occasions where current() is NULL... 

Apologies in advance for a wordy, probably stupid question, but I'm
stumped.   

If this is not the right approach for what I'm trying to do (e.g. a
kernel space getcwd()), can someone point me to something else I can try?

Thanks in advance, 

Mike Welles


----------------------------------------

(this is the greatly reduced version which does nothing but try and
reference current->fs->pwd)

void fill_full_path(char *name)
{ 
    if (current==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current == NULL\n"); 
#endif
	  return; 
    }

  if (current->fs==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current-> == NULL\n"); 
#endif
	  return; 
    }

  if (current->fs->pwd==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current->fs->pwd == NULL\n"); 
#endif
	  return; 
    }

    return; 
}








This is probably a stupid question: I've been working on a kernel
module to report on "changed files". 

It works just fine -- I wrap the orignal system calls with my
replacements which queue the filenames being modified, and when
another proccess reads from the device or proc entry, they get a nice
snapshot of what's going on in the system -- except that all the paths
are relative to the calling process. 

So, a little ignorance being a dangerous thing, I thought I'd be clever
and manually reconstruct the full path by walking up
current->fs->pwd->d_parent and padding d_name to the filename until it
hits root.

Unfortunatly, this approach causes kernel panics.  e.g., the attached
code snippet will inevitably bring down the machine if I call it
during in my replacement open, mkdir, rmdir, unlink routines -- and
tehy all work fine without itq. 

What am I not getting? I do see, before I go down, that there's a few
occasions where current() is NULL... 

Apologies in advance for a wordy, probably stupid question, but I'm
stumped.   

If this is not the right approach for what I'm trying to do (e.g. a
kernel space getcwd()), can someone point me to where I should look?

Thanks in advance, 

Mike Welles


----------------------------------------

(this is the greatly reduced version which does nothing but try and
reference current->fs->pwd)

void fill_full_path(char *name)
{ 
    if (current==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current == NULL\n"); 
#endif
	  return; 
    }

  if (current->fs==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current-> == NULL\n"); 
#endif
	  return; 
    }

  if (current->fs->pwd==NULL) 
    { 
#ifdef DEBUG
	  printk("ERROR! current->fs->pwd == NULL\n"); 
#endif
	  return; 
    }

    return; 
}






Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTHMC2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 22:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271336AbTHMC2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 22:28:55 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6788 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271335AbTHMC2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 22:28:53 -0400
Subject: Re: generic strncpy - off-by-one error
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: bernd@firmix.at, Anthony.Truong@mascorp.com, alan@lxorguk.ukuu.org.uk,
       schwab@suse.de, ysato@users.sourceforge.jp, willy@w.ods.org,
       Valdis.Kletnieks@vt.edu, william.gallafent@virgin.net
Content-Type: text/plain
Organization: 
Message-Id: <1060741101.948.245.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2003 22:18:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're all wrong. This is some kind of programming
test for sure!

Let us imagine that glibc has a correct version.
By exhaustive testing, I found a version that works.
Here it is, along with the test code:

//////////////////////////////////////////////////////
#define _GNU_SOURCE
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

// first correct implementation!
char * strncpy_good(char *dest, const char *src, size_t count){
  char *tmp = dest;
  memset(dest,'\0',count);
  while (count-- && (*tmp++ = *src++))
    ;
  return dest;
}

static char ref[32];
static char hmm[32];

static char s0[] = "";
static char s1[] = "1";
static char s2[] = "12";
static char s6[] = "123456";
static char s7[] = "1234567";
static char s8[] = "12345678";
static char s9[] = "123456789";

static void tester(const char *src, size_t count){
  memset(ref,'%',sizeof ref);
  memset(hmm,'%',sizeof hmm);
  strncpy     (ref+2,src,count);
  strncpy_good(hmm+2,src,count);
  if(memcmp(ref,hmm,sizeof hmm)){
    printf("error @ size %d\n",(int)count);
  }
}  
   
int main(int argc, char *argv[]){
  int i = 15;
  while(i--){
    tester(s0,i);
    tester(s1,i);
    tester(s2,i);
    tester(s6,i);
    tester(s7,i);
    tester(s8,i);
    tester(s9,i);
  }
  return 0;
}
////////////////////////////////////////////////////////////



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUJENZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUJENZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJENZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:25:32 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:11321 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S269022AbUJENZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:25:30 -0400
Date: Tue, 5 Oct 2004 15:27:41 +0200
From: "Andrei A. Voropaev" <av@simcon-mt.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: large auto variables cause segfault under 2.6
Message-ID: <20041005132741.GD28160@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring very large auto variables cause segfaults in the program under
2.6 kernel.

Take a look at this program.

  int main( int argc, char **argv )
  {
       unsigned char  bRet = 0;
  
       char tst[67123456];
  
  
       const char* pcSupportedParams = "d:t:lV:C:cP:h";
  
       printf("pcSupportedParams = %s\n");
       return 0;
  }

When compiled it produces segfault under kernel 2.6.8.1. The problem is
with that large array. Under 2.4 kernel the program gets its memory
region automatically extended to accomodate for large auto variables.
Under 2.6 it gets segment violation signal.

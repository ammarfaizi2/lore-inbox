Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVCBGR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVCBGR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVCBGR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:17:27 -0500
Received: from web52207.mail.yahoo.com ([206.190.39.89]:43890 "HELO
	web52207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbVCBGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:17:20 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=5fsGk/3NKCUgKYnhTMoJjgZoeccIb+gTpZnNYSITPhV6JnKtS4m9O34E89cS+NS8WSS1HHySOK/jLuIBqrpJHFXFk0/LAtKDqhnGfHzbuhBNpv4XKMuqNUILgCz9AX9s/2rEMekkzBYG8yfBedlSJmHTdkLdekNFqFSS9oHxXiY=  ;
Message-ID: <20050302061720.74613.qmail@web52207.mail.yahoo.com>
Date: Tue, 1 Mar 2005 22:17:20 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: some /proc understandings
To: linux-kernel@vger.kernel.org, lkg india <lkg_india@yahoogroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
         1) I want to know how much can i write to
/proc entry file?? Is there any limitation on file
size???
         2)Also how can i call /proc entry files
proc_read_myfile function on that file by another
kernel module call? What parameters i require to pass
and how? Say i have read functions as 

struct myfile_data_t {
  char value[8];
};
struct proc_dir_entry *myfile_file;
struct myfile_data_t myfile_data;

int proc_read_myfile(char *page, char **start, off_t
off, int count, int *eof, void *data)
{
  int len;

/* cast the void pointer of data to myfile_data_t*/
  struct myfile_data_t *myfile_data=(struct
myfile_data_t *)data;

/* use sprintf to fill the page array with a string */
  len = sprintf(page, "%s", myfile_data->value);
    return len;
}

Then can it possible that i can call proc_read_myfile
from another kernel module?? Instead read file from
user level call?
   3) Also Is following code valid of creating /proc
files with different file name created by passing
function cr_proc(fname)?

struct proc_dir_entry *entnew;
int cr_proc(char *fname)
{
        if ((entnew1 = create_proc_entry(fname,
S_IRUGO | S_IWUSR, NULL)) == NULL)
        return -EACCES;
       entnew1->proc_fops = &proc_file_operations;
}
static struct file_operations proc_file_operations = {
    open:       proc_open,
    release:    proc_release,
    read:       proc_read,
    write:      proc_write,
};

      What will happen if dynamic file names are going
to use same all above 4 functions???
regards,
linux_lover

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTDSRMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTDSRMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:12:46 -0400
Received: from ccnetbkup.hku.hk ([147.8.2.96]:7608 "EHLO mail2.hku.hk")
	by vger.kernel.org with ESMTP id S263420AbTDSRMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:12:39 -0400
Message-ID: <00df01c30698$7e041be0$ef17630a@tefs.com>
From: "George Chang" <h9916628@hkusua.hku.hk>
To: <linux-kernel@vger.kernel.org>
Subject: system hang when running a kernel module program invloving file operations and exchange of arrary of character
Date: Sun, 20 Apr 2003 01:24:10 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all


I loads the following code into kerenel as a module. The system hangs. I
dont know what's wrong. I guess the segmentation fault exists and array of
characters cause memory crash. Anyone has an idea? Thanks


Here is the code of the program

//RCFCOMM
     static char RFCOMM[]="/usr/csm/log/rfcomm.log";
 static char RFCOMM_sys[]="/usr/csm/log/rfcomm/sys.log";
 static char RFCOMM_err[]="/usr/csm/log/rfcomm/err.log";
 static char RFCOMM_ctrl[]="/usr/csm/log/rfcomm/ctrl.log";
 static char RFCOMM_rec[]="/usr/csm/log/rfcomm/rec.log";
 static char RFCOMM_warn[]="/usr/csm/log/rfcomm/warn.log";
 static char RFCOMM_snd[]="/usr/csm/log/rfcomm/snd.log";

 //SDP
 static char SDP[]="/usr/csm/log/sdp.log";
 static char SDP_sys[]="/usr/csm/log/sdp/sys.log";
 static char SDP_err[]="/usr/csm/log/sdp/err.log";
 static char SDP_ctrl[]="/usr/csm/log/sdp/ctrl.log";
 static char SDP_rec[]="/usr/csm/log/sdp/rec.log";
 static char SDP_warn[]="/usr/csm/log/sdp/warn.log";
 static char SDP_snd[]="/usr/csm/log/sdp/snd.log";

 //L2CAP
 static char L2CAP[]="/usr/csm/log/l2cap.log";
 static char L2CAP_sys[]="/usr/csm/log/l2cap/sys.log";
 static char L2CAP_err[]="/usr/csm/log/l2cap/err.log";
 static char L2CAP_ctrl[]="/usr/csm/log/l2cap/ctrl.log";
 static char L2CAP_rec[]="/usr/csm/log/l2cap/rec.log";
 static char L2CAP_warn[]="/usr/csm/log/l2cap/warn.log";
 static char L2CAP_snd[]="/usr/csm/log/l2cap/snd.log";

 //LMP
     static char LMP[]="/usr/csm/log/lmp.log";
 static char LMP_sys[]="/usr/csm/log/lmp/sys.log";
 static char LMP_err[]="/usr/csm/log/lmp/err.log";
 static char LMP_ctrl[]="/usr/csm/log/lmp/ctrl.log";
 static char LMP_rec[]="/usr/csm/log/lmp/rec.log";
 static char LMP_warn[]="/usr/csm/log/lmp/warn.log";
 static char LMP_snd[]="/usr/csm/log/lmp/snd.log";

     //MISC
     static char MISC[]="/usr/csm/log/misc.log";
 static char MISC_sys[]="/usr/csm/log/misc/sys.log";
 static char MISC_err[]="/usr/csm/log/misc/err.log";
 static char MISC_ctrl[]="/usr/csm/log/misc/ctrl.log";
 static char MISC_rec[]="/usr/csm/log/misc/rec.log";
 static char MISC_warn[]="/usr/csm/log/misc/warn.log";
 static char MISC_snd[]="/usr/csm/log/misc/snd.log";

void _csm_evtlogger(char *evtno, const char *rem) {

 int retval,orgfsuid,orgfsgid,fd,fd2,fd3,temp;
 mm_segment_t orgfs;

 static u8 buffer[5];
 static u8 buf[2];

 static u8* src = "/usr/csm/errtab.txt";

 int i = 0;
 //int k = 0;

 static u8 globall[30]; // global log
 static u8 subl[30]; // sub log

 // make the time stamp for event log
 unsigned int year=0,mon=0, day=0, hour=0, min=0, sec=0;
 static u8 cyear[4];
 static u8 cmon[2];
 static u8 cday[2];
 static u8 chour[2];
 static u8 cmin[2];
 static u8 csec[2];

 if ((rem == NULL) || (evtno == NULL)) {
  printk("1 CSM Error: Null remark");
  return;
 }

 if (evtno[0] == '1') {
  sprintf(globall,"%s", RFCOMM);
  if (evtno[1] == '1') {
   sprintf(subl, "%s", RFCOMM_sys);
  }
  else if (evtno[1] == '2') {
   sprintf(subl, "%s", RFCOMM_err);
  }
  else if (evtno[1] == '3') {
   sprintf(subl, "%s", RFCOMM_ctrl);
  }
  else if (evtno[1] == '4') {
   sprintf(subl, "%s", RFCOMM_rec);
  }
  else if (evtno[1] == '5') {
   sprintf(subl, "%s", RFCOMM_warn);
  }
  else if (evtno[1] == '6') {
   sprintf(subl, "%s", RFCOMM_snd);
  }
 }
 else if (evtno[0] == '2') {
  sprintf(globall, "%s", SDP);
  if (evtno[1] == '1') {
   sprintf(subl, "%s", SDP_sys);
  }
  else if (evtno[1] == '2') {
   sprintf(subl, "%s", SDP_err);
  }
  else if (evtno[1] == '3') {
   sprintf(subl, "%s", SDP_ctrl);
  }
  else if (evtno[1] == '4') {
   sprintf(subl, "%s", SDP_rec);
  }
  else if (evtno[1] == '5') {
   sprintf(subl, "%s", SDP_warn);
  }
  else if (evtno[1] == '6') {
   sprintf(subl, "%s", SDP_snd);
  }
 }
 else if (evtno[0] == '3') {
  sprintf(globall, "%s", L2CAP);
  if (evtno[1] == '1') {
   sprintf(subl, "%s", L2CAP_sys);
  }
  else if (evtno[1] == '2') {
   sprintf(subl, "%s", L2CAP_err);
  }
  else if (evtno[1] == '3') {
   sprintf(subl, "%s", L2CAP_ctrl);
  }
  else if (evtno[1] == '4') {
   sprintf(subl, "%s", L2CAP_rec);
  }
  else if (evtno[1] == '5') {
   sprintf(subl, "%s", L2CAP_warn);
  }
  else if (evtno[1] == '6') {
   sprintf(subl, "%s", L2CAP_snd);
  }
 }
 else if (evtno[0] == '4') {
  sprintf(globall, "%s", LMP);
  if (evtno[1] == '1') {
   sprintf(subl, "%s", LMP_sys);
  }
  else if (evtno[1] == '2') {
   sprintf(subl, "%s", LMP_err);
  }
  else if (evtno[1] == '3') {
   sprintf(subl, "%s", LMP_ctrl);
  }
  else if (evtno[1] == '4') {
   sprintf(subl, "%s", LMP_rec);
  }
  else if (evtno[1] == '5') {
   sprintf(subl, "%s", LMP_warn);
  }
  else if (evtno[1] == '6') {
   sprintf(subl, "%s", LMP_snd);
  }
 }
 else if (evtno[0] == '5') {
  sprintf(globall, "%s", MISC);
  if (evtno[1] == '1') {
   sprintf(subl, "%s", MISC_sys);
  }
  else if (evtno[1] == '2') {
   sprintf(subl, "%s", MISC_err);
  }
  else if (evtno[1] == '3') {
   sprintf(subl, "%s", MISC_ctrl);
  }
  else if (evtno[1] == '4') {
   sprintf(subl, "%s", MISC_rec);
  }
  else if (evtno[1] == '5') {
   sprintf(subl, "%s", MISC_warn);
  }
  else if (evtno[1] == '6') {
   sprintf(subl, "%s", MISC_snd);
  }
 }

 // get date & time from CMOS
 sec = CMOS_READ(RTC_SECONDS);
 min = CMOS_READ(RTC_MINUTES);
 hour = CMOS_READ(RTC_HOURS);
 day = CMOS_READ(RTC_DAY_OF_MONTH);
 mon = CMOS_READ(RTC_MONTH);
 year = CMOS_READ(RTC_YEAR);

 // change to human-readable format
 BCD_TO_BIN(sec);
 BCD_TO_BIN(min);
 BCD_TO_BIN(hour);
 BCD_TO_BIN(day);
 BCD_TO_BIN(mon);
 BCD_TO_BIN(year);

 // as for year 2003, return 3. So check if there is a need to re-format
 if ((year += 1900) < 1970)
  year += 100;
 sprintf(cyear,"%d",year);
 // manipulate date & time variables into the forms of character
 if (mon < 10)
  sprintf(cmon,"0%d",mon);
 else
  sprintf(cmon,"%d",mon);
 if (day < 10)
  sprintf(cday,"0%d",day);
 else
  sprintf(cday,"%d",day);
 if (hour < 10)
  sprintf(chour,"0%d",hour);
 else
  sprintf(chour,"%d",hour);
 if (min < 10)
  sprintf(cmin,"0%d",min);
 else
  sprintf(cmin,"%d",min);
 if (sec < 10)
  sprintf(csec,"0%d",sec);
 else
  sprintf(csec,"%d",sec);

 //sprintf(datetime, "%s/%s/%d %s:%s:%s ",cmon,cday,year,chour,cmin,csec);

 // Save uid and gid used for filesystem access.
 // Set user and group to 0 (root)

 orgfsuid=current->fsuid;
 orgfsgid=current->fsgid;
 current->fsuid=current->fsgid=0;
 // save FS register and set FS register to kernel
 // space, needed for read and write to accept
 // buffer in kernel space.

 orgfs=get_fs();
 set_fs(KERNEL_DS);
 if ((buffer != NULL) && (buf != NULL)) {
  if (((fd = sys_open(src, O_RDONLY, 0)) > 0) && ((fd2 =
sys_open(globall,O_WRONLY|O_CREAT|O_APPEND, 0644)) > 0) && ((fd3 =
sys_open(subl,O_WRONLY|O_CREAT|O_APPEND, 0644)) > 0)){
   do {
    retval = sys_read(fd, buffer, 5);
    /*if (buffer != NULL)
     printk("2 Evtno : %s\n", buffer);
    else {
     printk("2 Read NULL at evtno (file)\n");
     return;
    }*/
    if (retval < 0)
     printk("Read error %d\n",-retval);
    if (retval > 0) {
     if (strncmp(buffer,evtno,5) == 0) {
      // get the comment from the error table (errtab.txt)

      retval = sys_write(fd2, cmon, 2);
      retval = sys_write(fd2, "/", 1);
      retval = sys_write(fd2, cday, 2);
      retval = sys_write(fd2, "/", 1);
      retval = sys_write(fd2, cyear, 4);
      retval = sys_write(fd2, " ", 1);
      retval = sys_write(fd2, chour, 2);
      retval = sys_write(fd2, ":", 1);
      retval = sys_write(fd2, cmin, 2);
      retval = sys_write(fd2, ":", 1);
      retval = sys_write(fd2, csec, 2);
      retval = sys_write(fd2, " ", 1);

      retval = sys_write(fd3, cmon, 2);
      retval = sys_write(fd3, "/", 1);
      retval = sys_write(fd3, cday, 2);
      retval = sys_write(fd3, "/", 1);
      retval = sys_write(fd3, cyear, 4);
      retval = sys_write(fd3, " ", 1);
      retval = sys_write(fd3, chour, 2);
      retval = sys_write(fd3, ":", 1);
      retval = sys_write(fd3, cmin, 2);
      retval = sys_write(fd3, ":", 1);
      retval = sys_write(fd3, csec, 2);
      retval = sys_write(fd3, " ", 1);

      i = 0;

      do {
       retval = sys_read(fd, buf, 2);
       //printk("%c",buffer[0]);
       if ((buf[0] != '\n') && (buf[1] != '\n')) {

        //printk("%s",buf);
        if ((retval = sys_write(fd2, buf,2)) < 0)
         printk("Write error!");
        if ((retval = sys_write(fd3, buf,2)) < 0)
         printk("Write error!");
       }
       else if (buf[0] != '\n') {
        //printk("%c",buf[0]);
        if ((retval = sys_write(fd2, buf,1)) < 0)
         printk("Write error!");
        if ((retval = sys_write(fd3, buf,1)) < 0)
         printk("Write error!");
       }
      } while ((buf[0] != '\n') && (buf[1] != '\n'));

      if ((retval = sys_write(fd2, " ",1)) < 0)
       printk("Write error!");
      if ((retval = sys_write(fd2, rem,_sizeof(rem))) < 0)
       printk("Write error!");
      if ((retval = sys_write(fd2, "\n",1)) < 0)
       printk("Write error!");
      if ((retval = sys_write(fd3, " ",1)) < 0)
       printk("Write error!");
      if ((retval = sys_write(fd3, rem,_sizeof(rem))) < 0)
       printk("Write error!");
      if ((retval = sys_write(fd3, "\n",1)) < 0)
       printk("Write error!");
      retval = -1; // stop reading file
     }
     else {
      do {
       retval = sys_read(fd, buf, 1);
      } while (buf[0] != '\n');
     }
    }
   } while (retval > 0);
   //printk("Buffer : %s\n",buffer);

   temp = sys_close(fd);
   temp = sys_close(fd2);
   temp = sys_close(fd3);
  }
  else
   printk("fd <= 0\n");
 }
 else {
  printk("Null Pointer for Buffer\n");
  return;
 }

 set_fs(orgfs);
 current->fsuid=orgfsuid;
 current->fsgid=orgfsgid;

}


Best Regards,

George Chang


